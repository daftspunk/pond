import Connection from './Connection'

export default class Model {

    constructor(...attributes) {
        Object.assign(this, ...attributes);
    }

    connection() {
        return Connection.get();
    }

    primaryKey() {
        return 'id';
    }

    getPrimaryKey() {
        return this[this.primaryKey()];
    }

    resource() {
        return `${this.constructor.name.toLowerCase()}s`;
    }

    /**
     * Helpers
     */

    hasId() {
        const id = this.getPrimaryKey();
        return this.isValidId(id);
    }

    isValidId(id) {
        return id !== undefined && id !== 0 && id !== '';
    }

    /**
     * Result
     */

    first() {
        return this.get().then(response => {
            let item;

            if (response.data) {
                item = response.data[0];
            } else {
                item = response[0];
            }

            return item || {};
        })
    }

    find(identifier) {
        if (identifier === undefined) {
            throw new Error('You must specify the param on find() method.');
        }

        return this.connection().then(async db => {
            try {
                const result = await db.get(identifier);
                return new this.constructor({ id: result._id, ...result });
            }
            catch (err) {
                console.log(err);
                return null
            }
        });
    }

    get() {
        return this.connection().then(async db => {
            const result = await db.find({
                selector: {
                    documentType: this.resource(),
                    // name: {
                    //     $gt: null
                    // }
                },
                // sort: ['name']
            });

            let collection = result.docs;
            collection = Array.isArray(collection) ? collection : [collection];

            collection = collection.map(c => {
                let { documentType, ...attrs } = c;
                let item = new this.constructor({ id: attrs._id, ...attrs });
                return item;
            });

            return collection;
        });
    }

    delete() {
        if (!this.hasId()) {
            throw new Error('This model has a empty ID.');
        }

        return this.connection().then(async db => {
            this._deleted = true;
            this._update();
        });
    }

    save() {
        if (!this.name) {
            throw new Error('Every object must have a name for now...');
        }

        return this.hasId() ? this._update() : this._create();
    }

    _create() {
        return this.connection().then(async db => {
            var objClone = Object.assign({}, this);

            objClone.documentType = this.resource();

            delete objClone[this.primaryKey()];

            const putResult = await db.post(objClone);

            return this._fillFromSave(putResult);
        });
    }

    _update() {
        return this.connection().then(async db => {
            var objClone = Object.assign({}, this);

            objClone.documentType = this.resource();

            delete objClone[this.primaryKey()];

            const putResult = await db.put(objClone);

            return this._fillFromSave(putResult);
        });
    }

    _fillFromSave(putResult) {
        let { id, rev, documentType, ...attrs } = putResult;

        let self = Object.assign(this, attrs);

        self._id = id;

        self._rev = rev;

        self[this.primaryKey()] = id;

        return self;
    }
}
