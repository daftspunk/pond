import Downloader from './Downloader';
import initializerConstants from '../../constants/InitializerConstants';
import websiteDb from '../../database/Website';
import { onAddWebsite, onSelectWebsite } from '../../actions/WebsiteActions';

/**
 * This class orchestrates initialization of new websites:
 * 
 *  - Downloading the October archive
 *  - Provisioning the website's environment
 *  - Managing the Pond Agent to extract the archive and set the configuration
 *  - Cleaning up everything after the initialization succeeds or fails
 */

export default class Initializer {
    constructor(website, serverManager, provisioner) {
        this.serverManager = serverManager;
        this.provisioner = provisioner;
        this.website = website;
    }

    /**
     * Downloads, provisions and installs October
     */
    async initWebsite() {
        // TODO - this should be default for Pond and
        // come from the environment-specific provisioner.

        var configuration = {
            database: {
                default: 'sqlite'
            }
        };

        Object.assign(configuration, this.website);
        delete configuration.runtime;

        try {
            const edgeUpdates = configuration.useAdvancedOptions && configuration.edgeUpdates;
            const downloader = new Downloader(this.website.runtime.initState.textLog, edgeUpdates);

            this.website.runtime.initState.step = initializerConstants.DOWNLOADING;
            const installerPath = await downloader.run();

            this.website.runtime.initState.step = initializerConstants.PROVISIONING;

            await this.provisioner.run(installerPath);
            try {
                this.serverManager.setExtractorModeOn();
                await this.serverManager.start();

                this.website.runtime.initState.step = initializerConstants.INSTALLING;
                // await this.installer.run(
                //     this.serverManager,
                //     configuration
                // )

                var newWebsite = await websiteDb.create(this.website);
            }
            catch (err) {
                this.provisioner.errorCleanup();
                throw err
            }
            finally {
                this.provisioner.cleanup();
            }

            this.website.runtime.initState.step = initializerConstants.DONE;
        }
        catch (err) {
            await this.cleanup();
            throw err;
        }

        await this.cleanup(true);

        // store.dispatch(onAddWebsite(newWebsite));
        // store.dispatch(onSelectWebsite(newWebsite));

        return newWebsite;
    }

    async validateProvisionerConfiguration(errorBag, websites) {
        return this.provisioner.validateConfiguration(errorBag, websites);
    }

    async cleanup(isSuccess) {
        this.website.runtime.initState.textLog.addLine('Stopping the environment...');
        await this.serverManager.stop();
        this.website.runtime.initState.textLog.addLine('Server stopped');

        console.log('Cleaning up the initializer for website '+this.website.name);

        if (isSuccess) {
            this.website.runtime.initState.textLog.addLine('Done');
        }

        this.serverManager = null;
        this.provisioner = null;
        this.website = null;
    }
}
