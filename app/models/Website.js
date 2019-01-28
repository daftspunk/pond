import Model from '../services/Database/Model'
import ProjectModel from './Project'

/**
 * Website model
 * - name
 * - projectId
 * - folderName
 * - fullPath
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

    indexes() {
        return [
            ['documentType', 'projectId']
        ];
    }

    async makeFullPath() {
        const project = await this.project();
        return project.basePath + '/' + this.folderName;
    }
}
