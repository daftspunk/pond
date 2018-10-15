import PondProvisionerBase from './PondProvisionerBase';

/**
 * Environment provisioner:
 *
 *  - Pond built-in environment
 *  - Win32 platform
 */

export default class Provisioner extends PondProvisionerBase {
    constructor(project) {
        super(project);
    }
}
