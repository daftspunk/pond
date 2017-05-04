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
     */
    cleanup () {
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
        this.serverManager.on('start', this._serverStarted)
        this.serverManager.on('stop', this._serverStopped)
        this.serverManager.on('error', this._serverError)
    }

    _serverStarted () {
        Store.dispatch('setProjectStatus', {
            projectId: project.id,
            status: EnvironmentStatus.ONLINE
        })
    }

    _serverStopped () {
        Store.dispatch('setProjectStatus', {
            projectId: project.id,
            status: EnvironmentStatus.OFFLINE
        })
    }

    _serverError (err) {
        Store.dispatch('setProjectStatus', {
            projectId: project.id,
            status: EnvironmentStatus.OFFLINE
        })

        // TODO - send the error through the Vuex action 
        // to the project's runtime state
    }
}

module.exports = Environment