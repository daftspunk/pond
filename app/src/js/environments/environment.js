class Environment {
    constructor (webServerManager, dbServerManager, provisioner, installer) {
        this.webServerManager = webServerManager
        this.dbServerManager = dbServerManager
        this.provisioner = provisioner
        this.installer = installer
    }

    setProjectInfo (project) {
        // Note - do not save references to projects
        // in environment objects.

        this.location = location.location
    }

    startServer () {
        
    }
}

module.exports = Environment