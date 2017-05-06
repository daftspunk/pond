const EnvironmentFactory = require('./factory')

class Pool {
    constructor () {
        this.environments = {}
    }

    get (project) {
        if (this.environments.hasOwnProperty(project.id)) {
            return this.environments[project.id]
        }

        console.log('Creating environment for '+project.id)

        var environment = this.environments[project.id] = EnvironmentFactory.createEnvironment(project)

        return environment
    }

    cleanup () {
        for (var projectId in this.environments) {
            this.environments[projectId].cleanup()
            // delete this.environments[projectId]
        }
    }
}

module.exports = new Pool()