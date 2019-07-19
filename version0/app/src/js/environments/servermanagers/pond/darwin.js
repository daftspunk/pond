import BaseManager from './'
import assets from '../../../assets'
import {resolve} from 'path'

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

export default Manager