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

    getFirstErrorField () {
        if (!this.hasErrors()) {
            return null
        }

        return Object.keys(this.errors)[0]
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

export default ErrorBag