/**
 * Web server manager base class.
 *
 * In self-contained environments (Docker, Vagrant)
 * the manager should actually start/stop the environment.
 *
 * Server managers must emit the following events:
 *  - start
 *  - stop
 *  - log
 */

const EventEmitter = require('events').EventEmitter
const request = require('request')

class Manager extends EventEmitter {
    constructor (project) {
        super()

        this.project = project
        this.extractorMode = false
    }

    async start () {
        throw new Error('Implement start() in a child server manager class')
    }

    async stop () {
        throw new Error('Implement start() in a child server manager class')
    }

    async restart() {
        await this.stop()
        await this.start()
    }

    getLocalUrl () {
        throw new Error('Implement getLocalUrl() in a child server manager class')
    }

    getChildProcessCommand () {
        throw new Error('Implement getChildProcessCommand() in a child server manager class')
    }

    getServerStartTimeout () {
        throw new Error('Implement getServerStartTimeout() in a child server manager class')
    }

    getServerStopTimeout () {
        throw new Error('Implement getServerStopTimeout() in a child server manager class')
    }

    getSwitchFromExtractorRequiresRestart () {
        return false
    }

    setExtractorModeOn() {
        this.extractorMode = true
    }

    setExtractorModeOff() {
        this.extractorMode = false
    }

    async waitWebServerStarted () {
        return this._makeTestRequest(this.getServerStartTimeout(), true)
    }

    async waitWebServerStopped () {
        return this._makeTestRequest(this.getServerStopTimeout(), false)
    }

    //
    // Private methods
    //

    async _makeTestRequest (timeout, waitForStart) {
        const currentTime = new Date().getTime()
        const endTime = currentTime + timeout
        const connectioTimeout = 200
        const retryInterval = 300

        // TODO: check if the error 500 is considered
        // as a running state (it must be so)

        return new Promise((resolve, reject) => {
            var doRequest = () => {
                console.log('Pinging the server...')

                request
                    .get(this.getLocalUrl(), {'timeout': connectioTimeout})
                    .on('response', response => {
                        console.log('Server response received')

                        if (waitForStart) {
                            resolve()
                        }
                        else {
                            nextOrReject()
                        }
                    })
                    .on('error', err => {
                        console.log('Error received', err)

                        if (waitForStart) {
                            nextOrReject()
                        }
                        else {
                            resolve()
                        }

                        // if (err.code === 'ETIMEDOUT') {
                        //     // Wait more...
                        // }
                    })
            }

            var nextOrReject = () => {
                if (new Date().getTime() < endTime) {
                    setTimeout(doRequest, retryInterval)

                    return
                }
                else {
                    reject()
                }
            }

            doRequest()
        })

    }
}

module.exports = Manager