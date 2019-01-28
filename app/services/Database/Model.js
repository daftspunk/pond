import Builder from './Builder';
import Connection from './Connection'

export default class Model {

    constructor(...attributes) {
        if (attributes.length === 0) {
            this._builder = new Builder(this);
        } else {
            Object.assign(this, ...attributes);
        }
    }

    fill(...attributes) {
        Object.assign(this, ...attributes);
    }

    //
    // Setup
    //

    connection() {
        return Connection.get()
            .then(db => this.applyIndexes(db));
    }

    applyIndexes(db) {
        return new Promise((resolve, reject) => {
            const indexPromises = [
                db.createIndex({
                    index: {
                        fields: ['documentType']
                    }
                })
            ];
            this.indexes().map(index => {
                indexPromises.push(db.createIndex({
                    index: {
                        fields: index
                    }
                }))
            })

            Promise.all(indexPromises)
                .then(() => resolve(db))
                .catch(reject);
        });
    }

    indexes() {
        return [
            // ['name'],
            // ['documentType', 'name']
        ];
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
     * Query
     */

    where(field, value) {
        this._builder.where(field, value);

        return this;
    }

    whereIn(field, array) {
        this._builder.whereIn(field, array);

        return this;
    }

    orderBy(...args) {
        this._builder.orderBy(...args);

        return this;
    }

    limit(value) {
        this._builder.limit(value);

        return this;
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
                return null;
            }
        });
    }

    get() {
        return this.connection().then(async db => {
            let lookup = this._builder.query();

            lookup.selector = {
                ...lookup.selector || {},
                documentType: this.resource()
            }

            const result = await db.find(lookup);

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
