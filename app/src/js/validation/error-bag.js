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

    cleanup () {
        this.errors = {}
    }
}

module.exports = ErrorBag