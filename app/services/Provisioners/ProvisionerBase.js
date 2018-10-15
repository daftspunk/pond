import fileSystem from '../../utils/filesystem';

/**
 * Environment provisioner base class.
 */
export default class Provisioner {
    constructor(website) {
        this.website = website;
    }

    getInstallerPackagePath() {
        return this.website.location + '/installer.pak';
    }

    async validateConfiguration(errorBag, websites) {
        throw new Error('Implement validateConfiguration() in a child provisioner class');
    }

    async run() {
        throw new Error('Implement run() in a child provisioner class');
    }

    async moveInstaller(installerTmpPath) {
        this.website.runtime.initState.textLog.addLine('Copying the installer');
        try {
            await fileSystem.copy(installerTmpPath, this.getInstallerPackagePath());
        }
        finally {
            fileSystem.unlinkSync(installerTmpPath);
        }
    }

    async run(installerTmpPath) {
        // The default implementation moves the installer package
        // to the website's directory.

        await this.moveInstaller(installerTmpPath);
    }

    async cleanup() {
        fileSystem.unlinkSync(this.getInstallerPackagePath());
        this.website = null;
        console.log('Cleaning up the provisioner');
    }

    async errorCleanup() {
        // Implement in child classes if needed
    }
}
