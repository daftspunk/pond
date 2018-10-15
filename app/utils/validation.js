import fileSystem from 'fs-extra';

export function toSafeString(value) {
    if (value === undefined || value === null) {
        return '';
    }

    return (value + '').trim();
}

export function isDirectory(path) {
    return fileSystem.isDirectory(path);
}

export function isDirectoryEmpty(path) {
    return fileSystem.isDirectoryEmpty(path);
}
