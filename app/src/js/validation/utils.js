function toSafeString(value) {
    if (value === undefined || value === null) {
        return ''
    }

    return String(value).trim()
}

function isEmptyString(value) {
    return toSafeString(value).length == 0
}

function isInteger(value) {
    return /^[0-9]+$/.test(toSafeString(value))
}

function isDirectory(path) {
    const fs = nw.require('fs')

    try {
        const stat = fs.statSync(path)

        return (stat.isDirectory())
    } catch (err) {
        return false
    }
}

function isDirectoryEmpty(path) {
    const fs = nw.require('fs')
    const contents = fs.readdirSync(path)

    return !contents.some(fileName => {
        return fileName.charAt(0) !== '.'
    })
}

module.exports = {
    toSafeString,
    isEmptyString,
    isInteger,
    isDirectory,
    isDirectoryEmpty
}