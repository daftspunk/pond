const EnvironmentFactory = require('./factory')

class Pool {
    constructor () {
        this.environments = {}
    }

    get (project) {
        if (this.environments.hasOwnProperty(project.id)) {
            return this.environments[project.id]
        }

        return this.environments[project.id] = EnvironmentFactory.createEnvironment(project)
    }
}

module.exports = new Pool()