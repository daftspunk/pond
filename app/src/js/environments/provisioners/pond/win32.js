import BaseProvisioner from './'

/**
 * Environment provisioner: 
 *
 *  - Pond built-in environment
 *  - Win32 platform
 */

class Provisioner extends BaseProvisioner {
    constructor (project) {
        super(project)
    }
}

export default Provisioner
