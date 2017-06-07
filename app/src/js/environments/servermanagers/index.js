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

    async stop () {
        throw new Error('Implement start() in a child server manager class')
    }

    getLocalUrl () {
        throw new Error('Implement getLocalUrl() in a child server manager class')
    }

    getChildProcessCommand () {
        throw new Error('Implement getChildProcessCommand() in a child server manager class')
    }

    //
    // Private methods
    //

    async _makeTestRequest () {
        return new Promise((resolve, reject) => {
            request
                .get(this.getLocalUrl(), {'timeout': 200})
                .on('response', response => {
                    resolve()
                })
                .on('error', err => {
                    reject()
                    // if (err.code === 'ETIMEDOUT') {
                    //     // Wait more...
                    // }
                })
        })

    }

    async _waitWebServerStarted (timeout) {
        return new Promise((resolve, reject) => {
            var currentTime = new Date().getTime(),
                endTime = currentTime + timeout

            while (new Date().getTime() < endTime) {
                if ( await _makeTestRequest() ) {
                    resolve()
                }
            }

            reject()
        })
    }
}

module.exports = Manager