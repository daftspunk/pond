const BaseManager = require('./')
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
}

module.exports = Manager