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
    }

    async start () {
        throw new Error('Implement start() in a child server manager class')
    }

    stop () {
        throw new Error('Implement start() in a child server manager class')
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

    async waitWebServerStarted () {
        return this._makeTestRequest(this.getServerStartTimeout())
    }

    //
    // Private methods
    //

    async _makeTestRequest (timeout) {
        const currentTime = new Date().getTime()
        const endTime = currentTime + timeout
        const connectioTimeout = 200
        const retryInterval = 300

        return new Promise((resolve, reject) => {
            var doRequest = () => {
                console.log('Pinging the server...')

                request
                    .get(this.getLocalUrl(), {'timeout': connectioTimeout})
                    .on('response', response => {
                        console.log('Server response received')
                        resolve()
                    })
                    .on('error', err => {
                        console.log('Error received', err)

                        if (new Date().getTime() < endTime) {
                            setTimeout(doRequest, retryInterval)

                            return
                        }
                        else {
                            reject()
                        }
                        // if (err.code === 'ETIMEDOUT') {
                        //     // Wait more...
                        // }
                    })
            }

            doRequest()
        })

    }
}

module.exports = Manager