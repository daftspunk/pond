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
        // return '/usr/bin/php'
        return '/Users/alexeybobkov/October/pond/php5-7.1.4-20170506-100436/bin/php'
    }
}

module.exports = Manager