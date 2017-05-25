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

module.exports = {
    toSafeString,
    isEmptyString,
    isInteger
}