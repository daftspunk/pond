import { EventEmitter } from 'events'

export default class Container extends EventEmitter {

    static _injectedIndex = 1

    _classes = new Map()

    _instances = new Map()

    set(classname, optParams, optSetters) {
        let index = Container._injectedIndex++
        classname._injectedIndex = index
        let params = optParams || []
        let setters = optSetters || {}
        this._classes.set(index, {classname, params, setters})
    }

    has(value) {
        return value._injectedIndex > 0
    }

    get(value) {
        if (value._injectedIndex) {
            let index = value._injectedIndex
            if (!this._instances.has(index)) {
                if (!this._classes.has(index)) {
                    throw Error('Class `'+ index + '` not set.')
                }
                this._create(index)
            }
            return this._instances.get(index)
        }
        return value
    }

    _reference(value) {
        return this.get(value)
    }

    _references(traversable) {
        let values = []
        for (let key in traversable) {
            if (traversable.hasOwnProperty(key)) {
                values[key] = this._reference(traversable[key])
            }
        }
        return values
    }

    _setters(instance, setters) {
        for (let name in setters) {
            if (setters.hasOwnProperty(name)) {
                if (!!instance[name]) {
                    instance[name](setters[name])
                }
            }
        }
    }

    _createInstance(classname, params, setters) {
        let instance = new classname(...params)
        this._setters(instance, setters)
        return instance
    }

    _create(index) {
        let {classname, params, setters} = this._classes.get(index)
        params = this._references(params)
        setters = this._references(setters)
        this._instances.set(index, this._createInstance(
            classname, params, setters
        ))
    }
}
