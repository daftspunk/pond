import PouchDB from 'pouchdb'
import PouchDbFind from 'pouchdb-find'

PouchDB.plugin(PouchDbFind);

/**
 * Database Connection
 */
class Connection {
    constructor() {
        this.database = null;
    }

    get() {
        if (this.database === null) {
            this.database = new PouchDB('octobercms-pond', {
                adapter: 'idb',
                auto_compaction: true
            });

            return this._initializeDatabase();
        }

        return Promise.resolve(this.database);
    }

    //
    // Private methods
    //

    _initializeDatabase() {
        return new Promise((resolve, reject) => {
            Promise.all([
                // Uncomment to clean up the database. Restart the app after that.
                // this.database.destroy(),

                // These are here in case there is a need for global indexes
                // this.database.createIndex({
                //     index: {
                //         fields: ['name']
                //     }
                // }),
                // this.database.createIndex({
                //     index: {
                //         fields: ['documentType', 'name']
                //     }
                // })
            ]).then(() => {
                resolve(this.database);
            }).catch(reject);
        });
    }
}

export default new Connection;
