import PondServerBase from './PondServerBase';
import { getPhpBinDir } from '../../utils/assets';
import { resolve } from 'path';

/**
 * Web server manager for Windows
 */
export default class Server extends PondServerBase {
    getChildProcessCommand() {
        return assets.getPhpBinDir() + '/win32/php.exe';
    }
}
