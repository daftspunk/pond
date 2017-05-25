const BaseProvisioner = require('../')
const PortFinder = require('../../port-finder')
const ValidationUtils = require('../../../validation/utils')

/**
 * Environment provisioner: 
 *
 *  - Pond built-in environment
 */

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

        // - USE THIS PortFinder.isInUseByAProject (port, projects)
    }
}

module.exports = Provisioner