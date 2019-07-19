import Model from '../services/Database/Model'
import ProjectModel from './Project'
import * as Server from '../services/Provision/Server'

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

const servers = {}

export default class Website extends Model {
    resource() {
        return 'website';
    }

    indexes() {
        return [
            ['documentType', 'projectId']
        ];
    }

    project() {
        return (new ProjectModel).find(this.projectId);
    }

    async makeFullPath() {
        const project = await this.project();
        return project.basePath + '/' + this.folderName;
    }

    publicUrl() {
        return 'http://localhost:' + this.localPort;
    }

    adminUrl() {
        return 'http://localhost:' + this.localPort + '/backend';
    }

    canServe() {
        return Server.canServe(this.fullPath);
    }

    canInstall() {
        return Server.canInstall(this.fullPath);
    }

    isServing() {
        return !!servers[this.id];
    }

    async startServer(logger) {
        if (!servers[this.id]) {
            servers[this.id] = Server.newServer(logger.logFunc(), this.fullPath, this.localPort);
        }

        await servers[this.id].start();
        return servers[this.id];
    }

    async stopServer() {
        if (servers[this.id]) {
            await servers[this.id].stop();
            servers[this.id] = null;
        }
    }
}
