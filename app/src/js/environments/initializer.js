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
    }

    /**
     * Downloads, provisions and installs October
     */
    async initProject() {
        // TODO - this should be default for Pond and
        // come from the environment-specific provisioner.
        // It should be set in the new project state
        // from the default and loaded here from the project.
        const configuration = {
            database: {
                default: 'sqlite'
            }
        }

        try {
            const downloader = new Downloader(this.project.initState.textLog)

            this.project.initState.step = InitializationState.DOWNLOADING
            const installerPath = await downloader.run()

            this.project.initState.step = InitializationState.PROVISIONING
            await this.provisioner.run(installerPath)

            try {
                this.serverManager.setExtractorModeOn()
                await this.serverManager.start()

                this.project.initState.step = InitializationState.INSTALLING
                await this.installer.run(
                    this.serverManager,
                    configuration
                )
            }
            catch (err) {
                this.provisioner.errorCleanup()
                throw err
            }
            finally {
                this.provisioner.cleanup()
            }

            this.project.initState.step = InitializationState.DONE
        }
        catch (err) {
            await this.cleanup()
            throw err
        }

        await this.cleanup(true)
    }

    async validateProvisionerConfiguration (errorBag, projects) {
        return this.provisioner.validateConfiguration(errorBag, projects)
    }

    async cleanup (isSuccess) {
        this.project.initState.textLog.addLine('Stopping the environment...')
        await this.serverManager.stop()
        this.project.initState.textLog.addLine('Server stopped')

        console.log('Cleaning up the initializer for project '+this.project.name)

        if (isSuccess) {
            this.project.initState.textLog.addLine('Done')
        }

        this.serverManager = null
        this.provisioner = null
        this.installer = null
        this.project = null
    }
}

module.exports = Initializer