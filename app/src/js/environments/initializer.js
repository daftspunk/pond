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
        try {
            const downloader = new Downloader(this.project.initState.textLog)

            this.project.initState.step = InitializationState.DOWNLOADING
            const installerPath = await downloader.run()

            this.project.initState.step = InitializationState.PROVISIONING
            await this.provisioner.run(installerPath)

            try {
                this.serverManager.setExtractorModeOn()
                await this.serverManager.start()
                this.serverManager.setExtractorModeOff()

                this.project.initState.step = InitializationState.INSTALLING
                await this.installer.runExtractor(
                    this.serverManager.getLocalUrl()
                )
            }
            catch (err) {
                this.provisioner.errorCleanup()
                throw err
            }
            finally {
                this.provisioner.cleanup()
            }

            // TODO: if switching the server from extractor to the normal mode 
            // requires a restart - restart the server. This is required for Pond,
            // because it runs PHP with server.php in the normal mode and without
            // any PHP file for the extractor mode. Add a method to the server
            // manager class to determine whether restart is required.

            // await this.installer.runConfigurator(
            //     this.serverManager.getLocalUrl()
            // )

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