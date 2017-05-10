const PouchDB = require('pouchdb')

PouchDB.plugin(require('pouchdb-find'));

class DbManager {
    constructor (project) {
        this.database = null
    }

    get () {
        if (this.database === null) {
            this.database = new PouchDB('octobercms-pond', {
                adapter: 'idb'
            })

            return this._initializeDatabase()
        }

        return new Promise.resolve(database)
    }

    //
    // Private methods
    //

    _initializeDatabase () {
        return new Promise((resolve, reject) => {
            Promise.all([
                this.database.createIndex({
                    index: {
                        fields: ['documentType', 'name']
                    }
                }),
                this.database.createIndex({
                    index: {
                        fields: ['documentType', 'clientId', 'name']
                    }
                })
            ]).then(() => {
                resolve(this.database)
            }).catch(reject)
        })
    }
}

module.exports = new DbManager()