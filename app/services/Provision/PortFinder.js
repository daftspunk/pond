
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

export async function getNextPort(startingPort, hostname) {
    if (!hostname) {
        hostname = 'localhost';
    }

    for (var port = startingPort; port <= 65535; port++) {
        if (!await this.isInUseByAnotherApp(port, hostname)) {
            return port;
        }
    }
}

export function isInUseByAnotherApp(port, hostname) {
    const net = window.require('net');
    const server = new net.Server();

    return new Promise((resolve, reject) => {
        server.on('error', err => {
            console.log(`Error listening port ${hostname}:${port}. Error: ${err}`);
            server.close();

            if (err.code === 'ENOTFOUND') {
                console.log(`Ignore DNS ENOTFOUND error, get free port ${hostname}:${port}`);
                resolve(false);
                return;
            }

            resolve(true);
        })

        server.listen(port, hostname, () => {
            port = server.address().port;
            server.close();

            console.log(`Found available port ${hostname}:${port}`);
            resolve(false);
        })
    })
}
