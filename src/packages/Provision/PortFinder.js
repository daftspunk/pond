
export function getNextWebsitePort(websites) {
    var startingPort = 8080;

    for (var port = startingPort; port <= 65535; port++) {
        if (!this.isInUseByAWebsite(port, websites)) {
            return port;
        }
    }

    return 65535;
}

export function isInUseByAWebsite(port, websites) {
    return websites.find(website => website.localPort == port);
}

export async function getNextPort(logger, startingPort, hostname) {
    if (!hostname) {
        hostname = 'localhost';
    }

    for (var port = startingPort; port <= 65535; port++) {
        if (!await this.isInUseByAnotherApp(logger, port, hostname)) {
            return port;
        }
    }
}

export function isInUseByAnotherApp(logger, port, hostname) {
    const net = window.require('net');
    const server = new net.Server();

    return new Promise((resolve, reject) => {
        server.on('error', err => {
            logger(`Error listening port ${hostname}:${port}. Error: ${err}`);
            server.close();

            if (err.code === 'ENOTFOUND') {
                logger(`Ignore DNS ENOTFOUND error, get free port ${hostname}:${port}`);
                resolve(false);
                return;
            }

            resolve(true);
        })

        server.listen(port, hostname, () => {
            port = server.address().port;
            server.close();

            logger(`Found available port ${hostname}:${port}`);
            resolve(false);
        })
    })
}
