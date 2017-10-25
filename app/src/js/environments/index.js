import environmentFactory from './factory'

class Pool {
    constructor () {
        this.environments = {}
    }

    get (project) {
        if (this.environments.hasOwnProperty(project.id)) {
            return this.environments[project.id]
        }

        console.log('Creating environment for '+project.id)

        var environment = this.environments[project.id] = environmentFactory.createEnvironment(project)

        return environment
    }

    makeNonCached (project) {
        return environmentFactory.createEnvironment(project)
    }

    cleanup () {
        for (var projectId in this.environments) {
            this.environments[projectId].cleanup()
            // delete this.environments[projectId]
        }
    }
}

export default new Pool()