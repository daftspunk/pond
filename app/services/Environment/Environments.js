import EnvironmentFactory from './EnvironmentFactory'

class Environments {
    constructor() {
        this.environments = {};
    }

    get(website) {
        if (this.environments.hasOwnProperty(website.id)) {
            return this.environments[website.id];
        }

        console.log('Creating environment for '+website.id);

        var environment = this.environments[website.id] = EnvironmentFactory.createEnvironment(website);

        return environment;
    }

    makeNonCached(website) {
        return EnvironmentFactory.createEnvironment(website);
    }

    cleanup() {
        for (var websiteId in this.environments) {
            this.environments[websiteId].cleanup();
            // delete this.environments[websiteId]
        }
    }
}

export default new Environments()
