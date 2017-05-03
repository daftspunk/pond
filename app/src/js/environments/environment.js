const EnvironmentTypes = require('./types')

class Environment {
    constructor (project, webServerManager, dbServerManager, provisioner, installer) {
        this.webServerManager = webServerManager
        this.dbServerManager = dbServerManager
        this.provisioner = provisioner
        this.installer = installer

        this._setProjectInfo(project)
    }

    _setProjectInfo (project) {
        // Note - do not save references
        // to projects in environment objects.

        this.location = project.location
        this.environmentType = project.environmentType
    }

    getEnvironmentTypeName () {
        return EnvironmentTypes.typeToString(this.environmentType)
    }

    /**
     * Starts the environment and servers associated with it
     */
    start () {
        return Promise.all([
            this.webServerManager.start(),
            this.dbServerManager.start()
        ])
    }

    /**
     * Stops the environment and servers associated with it
     */
    stop () {
        return Promise.all([
            this.webServerManager.stop(),
            this.dbServerManager.stop()
        ])
    }
}

module.exports = Environment