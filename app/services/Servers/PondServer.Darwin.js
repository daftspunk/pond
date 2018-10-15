import PondServerBase from './PondServerBase';
import { getPhpBinDir } from '../../utils/assets';
import { resolve } from 'path';

/**
 * Web server manager for OSX, etc
 */
export default class Server extends PondServerBase {
    getChildProcessCommand() {
        // return '/usr/bin/php'
        return resolve(getPhpBinDir()) + '/darwin/bin/php';
    }
}
