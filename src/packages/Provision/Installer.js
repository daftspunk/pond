import fileSystem from '@app/utils/filesystem';
import * as Downloader from './Downloader';
import * as Extractor from './Extractor';
import * as Server from './Server';
import * as PortFinder from './PortFinder';

//
// API
//

export const errPathExists = new Error('A website already exists at this location');

export function canDeploy(websitePath) {
    if (fileSystem.existsSync(websitePath)) {
        return errPathExists;
    }
}

export async function deployInstaller(logger, websitePath) {
    logger.progress(0);

    logger.log(`Creating website at location: ${websitePath}`);

    canDeploy(websitePath);

    const portNumber = await PortFinder.getNextPort(logger.logFunc(), 2000);

    logger.progress(1);

    logger.log('Downloading installer files');

    await Downloader.downloadInstaller(websitePath);

    await Extractor.copyExtractor(websitePath);

    logger.progress(2);

    const server = new Server.newServer(logger.logFunc(), websitePath, portNumber, false);

    await server.start();

    logger.progress(3);

    logger.log('Extracting install files');

    try {
        await Extractor.runExtractor(logger.logFunc(), portNumber);

        logger.log('Cleaning up temporary files');

        await Extractor.cleanupExtractor(websitePath);

        await Downloader.cleanupInstaller(websitePath);
    }
    finally {
        logger.progress(4);

        await server.stop();
    }

    logger.log("Job's done!");

    logger.progress(5);
}
