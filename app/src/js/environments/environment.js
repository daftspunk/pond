const EnvironmentTypes = require('./types')
const Store = require('../stores')
const EnvironmentStatus = require('./status')

class Environment {
    constructor (project, serverManager) {
        this.serverManager = serverManager
        this.project = project

        this._setupListeners()
    }

    getEnvironmentTypeName () {
        return EnvironmentTypes.typeToString(this.project.environmentType)
    }

    getLocalUrl () {
        return this.serverManager.getLocalUrl()
    }

    /**
     * Starts the environment and servers associated with it
     */
    async start () {
        return this.serverManager.start()
    }

    /**
     * Stops the environment and servers associated with it
     */
    async stop () {
        return this.serverManager.stop()
    }

    /**
     * Removes references and listeners
     * TODO: not in use yet. Call when deleting a project and on application exit.
     */
    cleanup () {
        this.stop()
        this.serverManager.removeAllListeners(['start', 'stop', 'log'])

        console.log('Cleaning up the environment for project '+this.project.name)

        this.serverManager = null
        this.project = null
    }

    //
    // Private methods
    //

    _setupListeners () {
        this.serverManager.on('start', () => this._serverStarted())
        this.serverManager.on('stop', () => this._serverStopped())
        this.serverManager.on('log', (message) => this._logMessage(message))
    }

    _serverStarted () {
        Store.getStore().dispatch('setProjectStatus', {
            projectId: this.project.id,
            status: EnvironmentStatus.ONLINE
        })
    }

    _serverStopped () {
        if (!this.project) {
            // The project is empty during the clean up,
            // it's safe to ignore any problems
            return
        }

        Store.getStore().dispatch('setProjectStatus', {
            projectId: this.project.id,
            status: EnvironmentStatus.OFFLINE
        })
    }

    _logMessage (message) {
        if (!this.project) {
            // The project is empty during the clean up,
            // it's safe to ignore any problems
            return
        }

        Store.getStore().dispatch('logServerEvent', {
            projectId: this.project.id,
            message: message
        })
    }
}

module.exports = Environment