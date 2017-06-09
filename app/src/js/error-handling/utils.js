function getErrorString(err) {
    if (typeof(err) === 'string') {
        return err
    }

    if (err.message !== undefined) {
        return err.message
    }

    return 'Unknown error'
}

module.exports = {
    getErrorString
}