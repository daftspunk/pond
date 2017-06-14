const BaseProvisioner = require('../')
const PortFinder = require('../../port-finder')
const ValidationUtils = require('../../../validation/utils')
const EnvironmentStatus = require('../../status')
const fileSystem = require('../../../filesystem')
const assets = require('../../../assets')

/**
 * Environment provisioner: 
 *
 *  - Pond built-in environment
 */

const scriptName = 'server.php'

class Provisioner extends BaseProvisioner {
    async validateConfiguration(errorBag, projects) {
        if (ValidationUtils.isEmptyString(this.project.localPort)) {
            errorBag.add('localPort', 'projects.create_project.error_local_port_empty')
            return
        }

        if (!ValidationUtils.isInteger(this.project.localPort)) {
            errorBag.add('localPort', 'projects.create_project.error_local_port_not_integer')
            return
        }

        const otherProject = PortFinder.isInUseByAProject(this.project.localPort, projects)
        if (otherProject && otherProject.id != this.project.id) {
            errorBag.add('localPort', 'projects.create_project.error_local_port_used_by_another_project')
            return
        }

        try {
            await PortFinder.isInUseByAnotherApp(this.project.localPort, '127.0.0.1')
        }
        catch (e) {
            if (this.project.runtime && this.project.runtime.status != EnvironmentStatus.ONLINE) {
                // If the port is in use by this very project and it's online,
                // return no errors.

                return
            }

            errorBag.add('localPort', 'projects.create_project.error_local_port_used_by_another_app')
            return
        }
    }

    async run(installerTmpPath, textLog) {
        await super.run(installerTmpPath, textLog)

        // In Pond environment we don't need to provision anything.
        // Just put the archive and server.php to the project's
        // directory.

        const asssetsDir = assets.getAssetsDir()

        fileSystem.copy(asssetsDir + '/pond/' + scriptName, this.project.location + '/' + scriptName)
    }

    async errorCleanup() {
        return fileSystem.unlink(this.project.location + '/' + scriptName)
    }
}

module.exports = Provisioner