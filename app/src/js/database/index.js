const PouchDB = require('pouchdb')

PouchDB.plugin(require('pouchdb-find'));

class DbManager {
    constructor (project) {
        this.database = null
    }

    get () {
        if (this.database === null) {
            this.database = new PouchDB('octobercms-pond', {
                adapter: 'idb',
                auto_compaction: true
            })

            return this._initializeDatabase()
        }

        return Promise.resolve(this.database)
    }

    //
    // Private methods
    //

    _initializeDatabase () {
        return new Promise((resolve, reject) => {
            Promise.all([
                // this.database.destroy(), // Uncomment to clean up the database. Restart the app after that.
                this.database.createIndex({
                    index: {
                        fields: ['name']
                    }
                }),
                this.database.createIndex({
                    index: {
                        fields: ['documentType', 'name']
                    }
                })
            ]).then(() => {
                resolve(this.database)
            }).catch(reject)
        })
    }
}

module.exports = new DbManager()