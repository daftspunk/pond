import fileSystem from '../../utils/filesystem';

/**
 * Scans a project directory for websites
 */
export default class Scanner {
    constructor(project) {
        this.project = project;
    }

    getProjectParentPath() {
        return this.project.location;
    }

    async run() {
        const dirPath = this.getProjectParentPath();
        let directories = await this.getDirectories(dirPath);
        return directories;
    }

    async getDirectories(path) {
        let filesAndDirectories = await fileSystem.readdir(path);
        let directories = [];

        await Promise.all(filesAndDirectories.map(name => {
            return fileSystem
                .stat(path + name)
                .then(stat => {
                    if (stat.isDirectory()) {
                        directories.push(name);
                    }
                });
        }));

        return directories;
    }
}
