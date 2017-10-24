import BaseProvisioner from '../'
import portFinder from '../../port-finder'
import validationUtils from '../../../validation/utils'
import environmentStatus from '../../status'
import fileSystem from '../../../filesystem'
import assets from '../../../assets'
import validator from 'validator'

/**
 * Environment provisioner: 
 *
 *  - Pond built-in environment
 */

const scriptName = 'server.php'

class Provisioner extends BaseProvisioner {
    async validateConfiguration(errorBag, projects) {
        if (validator.isEmpty(validationUtils.toSafeString(this.project.localPort))) {
            errorBag.add('localPort', 'projects.create_project.error_local_port_empty')
            return
        }

        if (!validator.isInt(validationUtils.toSafeString(this.project.localPort))) {
            errorBag.add('localPort', 'projects.create_project.error_local_port_not_integer')
            return
        }

        const otherProject = portFinder.isInUseByAProject(this.project.localPort, projects)
        if (otherProject && otherProject.id != this.project.id) {
            errorBag.add('localPort', 'projects.create_project.error_local_port_used_by_another_project')
            return
        }

        try {
            await portFinder.isInUseByAnotherApp(this.project.localPort, '127.0.0.1')
        }
        catch (e) {
            if (this.project.runtime && this.project.runtime.status != environmentStatus.ONLINE) {
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

export default Provisioner