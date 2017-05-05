const EnvironmentTypes = require('./types')
const Store = require('../stores')
const EnvironmentStatus = require('./status')

class Environment {
    constructor (project, serverManager, provisioner, installer) {
        this.serverManager = serverManager
        this.provisioner = provisioner
        this.installer = installer

        this._setProjectInfo(project)
        this._setupListeners()
    }

    getEnvironmentTypeName () {
        return EnvironmentTypes.typeToString(this.environmentType)
    }

    getLocalUrl () {
        return this.serverManager.getLocalUrl()
    }

    /**
     * Starts the environment and servers associated with it
     */
    start () {
        this.serverManager.start()
    }

    /**
     * Stops the environment and servers associated with it
     */
    stop () {
        this.serverManager.stop()
    }

    /**
     * Removes references and listeners
     * TODO: not in use yet. Call when deleting a project and on application exit.
     */
    cleanup () {
        this.stop()
        this.serverManager.removeAllListeners(['start', 'stop', 'error'])

        this.serverManager = null
        this.provisioner = null
        this.installer = null
    }

    //
    // Private methods
    //

    _setProjectInfo (project) {
        // Note - do not save references
        // to projects in environment objects.

        this.location = project.location
        this.environmentType = project.environmentType
        this.projectId = project.id
    }

    _setupListeners () {
        this.serverManager.on('start', () => this._serverStarted())
        this.serverManager.on('stop', () => this._serverStopped())
        this.serverManager.on('error', (err) => this._serverError(err))
    }

    _serverStarted () {
console.log('Got server started event')
        Store.getStore().dispatch('setProjectStatus', {
            projectId: this.projectId,
            status: EnvironmentStatus.ONLINE
        })
    }

    _serverStopped () {
console.log('Got server stopped event')
        Store.getStore().dispatch('setProjectStatus', {
            projectId: this.projectId,
            status: EnvironmentStatus.OFFLINE
        })
    }

    _serverError (err) {
console.log('Got server error event', err)
        Store.getStore().dispatch('logServerEvent', {
            projectId: this.projectId,
            error: err
        })

        // TODO - send the error through the Vuex action 
        // to the project's runtime state
    }
}

module.exports = Environment