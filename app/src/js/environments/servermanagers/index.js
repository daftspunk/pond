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

class Manager extends EventEmitter {
    constructor (project) {
        super()

        this.project = project
    }

    start () {
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
}

module.exports = Manager