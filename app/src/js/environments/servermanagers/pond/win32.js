import BaseManager from './'
import assets from '../../../assets'
import {resolve} from 'path'

/**
 * Web server manager: 
 *
 *  - Pond built-in environment
 *  - PHP command-line server
 *  - Win32 platform
 */

class Manager extends BaseManager {
    getChildProcessCommand () {
        return assets.getPhpBinDir() + '/win32/php.exe'
    }
}

export default Manager
