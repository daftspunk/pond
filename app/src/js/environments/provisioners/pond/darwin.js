const BaseProvisioner = require('./')

/**
 * Environment provisioner: 
 *
 *  - Pond built-in environment
 *  - Darwin platform
 */

class Provisioner extends BaseProvisioner {
    constructor (project) {
        super(project)
    }
}

module.exports = Provisioner