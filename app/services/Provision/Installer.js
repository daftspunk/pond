import * as Downloader from './Downloader'
import * as Extractor from './Extractor'
import * as Server from './Server'
import * as PortFinder from './PortFinder'

//
// API
//

export async function deployInstaller(websitePath) {
    var logger = function(msg) { console.log('LOG: '+msg); }

    var port = PortFinder.getNextPort(2000);

    await Downloader.downloadInstaller(websitePath);

    await Extractor.copyExtractor(websitePath);

    const server = new Server.newServer(websitePath, portNumber, logger, false);

    await server.start();

    try {
        await Extractor.runExtractor(portNumber, logger);

        await Extractor.cleanupExtractor(websitePath);

        await Downloader.cleanupInstaller(websitePath);
    }
    finally {
        await server.stop();
    }
}
