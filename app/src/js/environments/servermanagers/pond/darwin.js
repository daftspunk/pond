const BaseManager = require('./')
const spawn = require('child_process').spawn
const assets = require('../../../assets')
const resolve = require('path').resolve

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
        return resolve(assets.getPhpBinDir()) + '/darwin/bin/php'
    }
}

module.exports = Manager