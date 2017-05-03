/**
 * Database server manager base class.
 *
 * It's likely we don't need any real
 * implementations of a database server manager,
 * because:
 *
 * - Pond built-in server uses SQLite, which 
 *   doesn't need start/stop functionality.
 * - Docker and Vagrant have self-contained
 *   database server, which starts when the
 *   environment starts.
 * - External LAMP is not manageable with 
 *   Pond.
 */

class Manager {
    constructor (project) {
        // Don't keep references to the project
        // itself

        this.location = project.location
    }

    start () {
        return Promise.resolve()
    }

    stop () {
        return Promise.resolve()
    }
}

module.exports = Manager