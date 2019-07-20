import fileSystem from '@app/utils/filesystem';

//
// API
//

export async function scanProject(project) {
    const dirPath = getProjectParentPath(project);
    const directories = await getDirectories(dirPath);
    return directories;
}

//
// Internals
//

function getProjectParentPath(project) {
    return project.location;
}

async function getDirectories(path) {
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
