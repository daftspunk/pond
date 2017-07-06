const fileSystem = require('../../filesystem')

/**
 * Environment provisioner base class.
 */

class Provisioner {
    constructor (project) {
        this.project = project
    }

    getInstallerPackagePath () {
        return this.project.location + '/installer.pak'
    }

    async validateConfiguration(errorBag, projects) {
        throw new Error('Implement validateConfiguration() in a child provisioner class')
    }

    async run() {
        throw new Error('Implement run() in a child provisioner class')
    }

    async moveInstaller(installerTmpPath) {
        this.project.runtime.initState.textLog.addLine('Copying the installer')
        await fileSystem.copy(installerTmpPath, this.getInstallerPackagePath())

        nw.require('fs').unlinkSync(installerTmpPath)
    }

    async run(installerTmpPath) {
        // The default implementation moves the installer package
        // to the project's directory.

        await this.moveInstaller(installerTmpPath)
    }

    async cleanup () {
        nw.require('fs').unlinkSync(this.getInstallerPackagePath())
        this.project = null
        console.log('Cleaning up the provisioner')
    }

    async errorCleanup() {
        // Implement in child classes if needed
    }
}

module.exports = Provisioner