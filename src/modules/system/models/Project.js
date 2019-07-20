import Model from '@packages/Database/Model';
import app from '@app/utils/app';

/**
 * Project model
 * - name
 * - basePath
 * - description
 * - icon
 */
export default class Project extends Model {
    resource() {
        return 'project';
    }

    static newDefaultProject() {
        const project = new this;

        project.name = 'The Pond';

        project.basePath = app().storagePath();

        project.icon = null;

        return project;
    }
}
