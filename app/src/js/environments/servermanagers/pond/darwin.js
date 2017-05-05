const BaseManager = require('../')
const spawn = require('child_process').spawn

/**
 * Web server manager: 
 *
 *  - Pond built-in environment
 *  - PHP command-line server
 *  - Darwin platform
 */

class Manager extends BaseManager {
    getChildProcessCommand () {
        return '/usr/bin/php'
    }

    getLocalUrl () {
        return 'http://localhost:' + this.localPort
    }

    _setProjectInfo (project) {
        // Don't keep references to the project
        // itself

        super._setProjectInfo(project)

        this.localPort = project.localPort
    }
}

module.exports = Manager