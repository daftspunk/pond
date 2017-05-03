/**
 * Web server manager base class.
 *
 * In self-contained environments (Docker, Vagrant)
 * the manager should actually start/stop the environment.
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