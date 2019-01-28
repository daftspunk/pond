import Model from '../services/Database/Model'
import ProjectModel from './Project'

/**
 * Website model
 * - name
 * - projectId
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

    project() {
        return (new ProjectModel).find(this.projectId);
    }

    async fullPath() {
        const project = await this.project();
        return project.basePath + '/' + this.folderName;
    }
}
