const Downloader = require('./downloader')
const InitializationState = require('./initialization-state')

/**
 * This class orchestrates initialization of new projects:
 * 
 *  - Downloading the October archive
 *  - Provisioning the project's environment
 *  - Managing the Pond Agent to extract the archive and set the configuration
 *  - Cleaning up everything after the initialization succeeds or fails
 */

class Initializer {
    constructor (project, serverManager, provisioner, installer) {
        this.serverManager = serverManager
        this.provisioner = provisioner
        this.installer = installer
        this.project = project

        this._setupListeners()
    }

    /**
     * Downloads, provisions and installs October
     */
    async initProject() {
        const downloader = new Downloader(this.project.initState.textLog)

        this.project.initState.step = InitializationState.DOWNLOADING
        const installerPath = await downloader.run()

        this.project.initState.step = InitializationState.PROVISIONING
        await this.provisioner.run(installerPath)

        this.project.initState.textLog.addLine('Starting the environment...')
        await this.serverManager.start()
        this.project.initState.textLog.addLine('Environment is ready')

        this.project.initState.step = InitializationState.INSTALLING
        await this.installer.run()

        this.project.initState.step = InitializationState.DONE
    }

    async validateProvisionerConfiguration (errorBag, projects) {
        return this.provisioner.validateConfiguration(errorBag, projects)
    }

    cleanup () {
        this.serverManager.stop()
        this.serverManager.removeAllListeners(['log'])

        console.log('Cleaning up the initializer for project '+this.project.name)

        this.serverManager = null
        this.provisioner = null
        this.installer = null
        this.project = null
    }

    //
    // Private methods
    //

    _setupListeners () {
        this.serverManager.on('log', (message) => this._logMessage(message))
    }

    _logMessage (message) {
        this.project.initState.textLog.addLine(message)
    }
}

module.exports = Initializer