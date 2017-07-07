function getErrorString(err) {
    if (typeof(err) === 'string') {
        return err
    }

    if (err.message !== undefined) {
        return err.message
    }

    if (err.errors !== undefined) {
        if (Object.getOwnPropertyNames(err.errors).length > 1) {
            return 'projects.create_project.multiple_errors'
        }

        return 'projects.create_project.single_error'
    }

    return 'common.unknown_error'
}

module.exports = {
    getErrorString
}