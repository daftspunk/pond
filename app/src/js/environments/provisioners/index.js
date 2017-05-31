/**
 * Environment provisioner base classs.
 */

class Provisioner {
    constructor (project) {
        this.project = project
    }

    async validateConfiguration(errorBag, projects) {
        throw new Error('Implement validateConfiguration() in a child provisioner class')
    }

    async run() {
        throw new Error('Implement run() in a child provisioner class')
    }
}

module.exports = Provisioner