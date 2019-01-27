import Model from '../services/Database/Model';

/**
 * Website model
 * - name
 * - folderName
 * - description
 * - localPort
 * - isRemoteEnabled
 * - remoteHandleshake
 */
export default class Website extends Model {
    resource() {
        return 'website';
    }
}
