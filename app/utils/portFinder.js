class PortFinder {
    constructor() {
    }

    getNextPort(websites) {
        var startingPort = 8080;

        for (var port = startingPort; port <= 65535; port++) {
            if (!this.isInUseByAWebsite(port, websites)) {
                return port;
            }
        }

        return 65535;
    }

    isInUseByAWebsite(port, websites) {
        return websites.find(website => website.localPort == port);
    }

    isInUseByAnotherApp(port, hostname) {
        const { net } = require('electron');
        const server = new net.Server();

        return new Promise((resolve, reject) => {
            server.on('error', err => {
                console.log(`Error listening port ${hostname}:${port}. Error: ${err}`);
                server.close();

                if (err.code === 'ENOTFOUND') {
                    console.log(`Ignore DNS ENOTFOUND error, get free port ${hostname}:${port}`);
                    resolve(port);
                    return;
                }

                reject(err);
            })

            server.listen(port, hostname, () => {
                port = server.address().port;
                server.close();

                console.log(`Found available port ${hostname}:${port}`);
                resolve(port);
            })
        })
    }
}

export default new PortFinder();
