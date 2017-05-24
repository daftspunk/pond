class ErrorBag {
    constructor () {
        this.errors = {}
    }

    add (fieldName, errorMessage) {
        this.errors[fieldName] = errorMessage
    }

    has (fieldName) {
        return this.errors[fieldName] !== undefined
    }

    get (fieldName) {
        return this.errors[fieldName]
    }

    hasErrors () {
        for (var property in this.errors) {
            if (this.errors.hasOwnProperty(property)) {
                return true
            }
        }

        return false
    }

    cleanup () {
        this.errors = {}
    }
}

module.exports = ErrorBag