import fileSystem from '../filesystem'

function toSafeString(value) {
    if (value === undefined || value === null) {
        return ''
    }

    return (value + '').trim()
}

function isDirectory(path) {
    return fileSystem.isDirectory(path)
}

function isDirectoryEmpty(path) {
    return fileSystem.isDirectoryEmpty(path)
}

export default {
    toSafeString,
    isDirectory,
    isDirectoryEmpty
}