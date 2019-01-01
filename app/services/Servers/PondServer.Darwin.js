import PondServerBase from './PondServerBase';
import assets from '../../utils/assets';
import { resolve } from 'path';

/**
 * Web server manager for OSX, etc
 */
export default class Server extends PondServerBase {
    getChildProcessCommand() {
        // return '/usr/bin/php'
        return resolve(assets.getPhpBinDir()) + '/darwin/bin/php';
    }
}
