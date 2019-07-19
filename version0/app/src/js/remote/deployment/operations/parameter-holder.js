import schemaStrings from './schema-strings'
import Ajv from 'ajv'
import cloneDeep from 'clone-deep'

/**
 * Validates input parameters and returns their values.
 */

class ParameterHolder {
    constructor (parametersObject) {
        this._parameters = parametersObject
    }

    get (path, optional, defaultValue) {
        const parts = path.split('.')
        const normalizedDefaultValue = defaultValue === undefined ? null : defaultValue

        return this._getValueByPath(parts, this._parameters, path, optional, normalizedDefaultValue)
    }

    validate (schemaName) {
        const schema = this._getSchemaByName(schemaName)

        return this._validateWithSchemaObject(schema)
    }

    _validateWithSchemaObject (schemaObj) {
        const targetSchemaObject = this._makeTargetSchema(schemaObj)
        const ajv = new Ajv()

        const validate = ajv.compile(targetSchemaObject)

        if (!validate(this._parameters)) {
            throw new Error(this._formatError(validate.errors[0]))
        }

        return true
    }

    _makeTargetSchema (schemaObj) {
        // This was copied from PHP as is. It would be smarter to
        // combine schemas using Avj addSchema() tho.

        const commonRequired = this._getSchemaByName('COMMON_ARGUMENTS_REQUIRED')
        const commonProperties = this._getSchemaByName('COMMON_ARGUMENTS_PROPERTIES')
        const commonDefinitions = this._getSchemaByName('COMMON_DEFINITIONS')

        var targetSchemaObject = cloneDeep(schemaObj)

        if (targetSchemaObject.properties === undefined) {
            targetSchemaObject.properties = {}
        }

        if (targetSchemaObject.definitions === undefined) {
            targetSchemaObject.definitions = {}
        }

        if (targetSchemaObject.required === undefined) {
            targetSchemaObject.required = {}
        }

        Object.entries(commonProperties).forEach(([key, value]) => {
            targetSchemaObject.properties[key] = value
        })

        Object.entries(commonDefinitions).forEach(([key, value]) => {
            targetSchemaObject.definitions[key] = value
        })

        commonRequired.forEach(property => {
            targetSchemaObject.required.push(property)
        })

        return targetSchemaObject
    }

    _getSchemaByName (schemaName) {
        if (schemaStrings[schemaName] === undefined) {
            throw new Error(`Unknown JSON schema: ${schemaName}.`)
        }

        return schemaStrings[schemaName]
    }

    _formatError (error) {
        var message = error.message

        if (/should match pattern/.test(message)) {
            return `${error.dataPath}: invalid format`
        }

        if (error.dataPath) {
            return `${error.dataPath}: ${error.message}`
        }

        return error.message
    }

    _getValueByPath (parts, object, path, optional, defaultValue) {
        const first = parts.shift()

        if (typeof object === 'object') {
            if (!object.hasOwnProperty(first)) {
                if (!optional) {
                    throw new Error(`Parameter does not exist: ${path}`)
                }

                return defaultValue
            }
        } 
        else if (Array.isArray(object)) {
            if (!object.includes(first)) {
                if (!optional) {
                    throw new Error(`Parameter does not exist: ${path}`)
                }

                return defaultValue
            }
        }

        if (!parts.length) {
            return object[first]
        }

        return this._getValueByPath (parts, object[first], path, optional, defaultValue)
    }
}

export default ParameterHolder