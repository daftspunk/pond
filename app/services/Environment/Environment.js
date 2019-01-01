import EnvironmentTypes from './EnvironmentTypes';
import store from '../../utils/store';
import { onServerStarted, onServerStopped, onLogMessage } from '../../actions/WebsiteActions';

export default class Environment {
    constructor(website, serverManager) {
        this.serverManager = serverManager;
        this.website = website;

        this.serverManager.on('start', () => store.dispatch(onServerStarted(this.website)));
        this.serverManager.on('stop', () => store.dispatch(onServerStopped(this.website)));
        this.serverManager.on('log', (message) => store.dispatch(onServerStopped(this.website, message)));
    }

    getEnvironmentTypeName() {
        return EnvironmentTypes.typeToString(this.website.environmentType);
    }

    getLocalUrl() {
        return this.serverManager.getLocalUrl();
    }

    /**
     * Starts the environment and servers associated with it
     */
    async start() {
        return this.serverManager.start();
    }

    /**
     * Stops the environment and servers associated with it
     */
    async stop() {
        return this.serverManager.stop();
    }

    /**
     * Removes references and listeners
     * TODO: not in use yet. Call when deleting a website and on application exit.
     */
    cleanup() {
        this.stop();
        this.serverManager.removeAllListeners(['start', 'stop', 'log']);

        console.log('Cleaning up the environment for website ' + this.website.name);

        this.serverManager = null;
        this.website = null;
    }
}
