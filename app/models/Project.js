import Model from '../services/Database/Model';
import app from '../utils/app'

/**
 * Project model
 * - name
 * - basePath
 * - description
 */
export default class Project extends Model {
    resource() {
        return 'project';
    }

    static newDefaultProject() {
        const project = new this;

        project.name = 'The Pond';

        project.basePath = app().storagePath();

        return project;
    }
}
