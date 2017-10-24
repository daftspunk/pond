import environmentTypes from './types'
import store from '../stores'
import environmentStatus from './status'

class Environment {
    constructor (project, serverManager) {
        this.serverManager = serverManager
        this.project = project

        this._setupListeners()
    }

    getEnvironmentTypeName () {
        return environmentTypes.typeToString(this.project.environmentType)
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
        store.getStore().dispatch('setProjectStatus', {
            projectId: this.project._id,
            status: environmentStatus.ONLINE
        })
    }

    _serverStopped () {
        if (!this.project) {
            // The project is empty during the clean up,
            // it's safe to ignore any problems
            return
        }

        store.getStore().dispatch('setProjectStatus', {
            projectId: this.project._id,
            status: environmentStatus.OFFLINE
        })
    }

    _logMessage (message) {
        if (!this.project) {
            // The project is empty during the clean up,
            // it's safe to ignore any problems
            return
        }

        store.getStore().dispatch('logServerEvent', {
            projectId: this.project._id,
            message: message
        })
    }
}

export default Environment