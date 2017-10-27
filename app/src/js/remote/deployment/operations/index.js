/**
 * Base deployment operation class.
 */

class DeploymentOperation {
    constructor (parameters) {
        this._parameters = parameters
        this._parametersValidated = false
    }

    validateParameters () {
        this._parametersValidated = true
    }

    get () {
        if (!this._parametersValidated) {
            throw new Error('Parameters are not validated');
        }

        return _parameters
    }
}

export default DeploymentOperation