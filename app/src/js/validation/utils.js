const fileSystem = require('../filesystem')

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

module.exports = {
    toSafeString,
    isDirectory,
    isDirectoryEmpty
}