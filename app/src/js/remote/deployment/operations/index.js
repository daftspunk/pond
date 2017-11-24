/**
 * Base deployment operation class.
 */

class DeploymentOperation {
    constructor (parameterHolder) {
        this._parameterHolder = parameterHolder
    }

    validateParameters () {
    }

    get (path, optional, defaultValue) {
        return this._parameters.get(path, optional, defaultValue)
    }
}

export default DeploymentOperation