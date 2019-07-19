import Container from './Container'
import { createBrowserHistory } from 'history'

/**
 * App Container
 */
export default class Application extends Container {

    static instance;

    // Primary Redux store for the application.
    baseStore = null;

    // Indicates if application has been booted.
    booted = false;

    constructor(baseStore) {
        super();

        this.baseStore = baseStore;

        Application.setInstance(this);
    }

    history() {
        return createBrowserHistory();
    }

    store() {
        return this.baseStore;
    }

    storagePath() {
        const electron = window.require('electron');
        const app = electron.app || electron.remote.app;
        return app.getPath('userData');
    }

    distPath() {
        const electron = window.require('electron');
        const process = electron.process || electron.remote.process;
        return process.cwd() + '/dist';
    }

    tempPath() {
        const electron = window.require('electron');
        const app = electron.app || electron.remote.app;
        return app.getPath('temp');
    }

    //
    // Container
    //

    static setInstance(container) {
        Application.instance = container;
    }

    static getInstance() {
        return Application.instance;
    }

    //
    // Booting
    //

    boot() {
        if (this.booted) {
            return;
        }

        this.emit('booting');

        this.booted = true;

        this.emit('booted');
    }
}
