class PortFinder {
    constructor () {
        
    }

    getNextPort (projects) {
        var startingPort = 8080

        for (var port = startingPort; port <= 65535; port++) {
            if (!this.isInUseByAProject(port, projects)) {
                return port
            }
        }

        return 65535
    }

    isInUseByAProject (port, projects) {
        return projects.find(project => project.localPort == port)
    }

    isInUseByAnotherApp (port, hostname) {
        // Note - in the browser context we must use
        // nw.require to link native node.js modules.

        const net = nw.require('net')
        const server = new net.Server()

        return new Promise((resolve, reject) => {
            server.on('error', err => {
                console.log(`Error listening port ${hostname}:${port}. Error: ${err}`)
                server.close()

                if (err.code === 'ENOTFOUND') {
                    console.log(`Ignore DNS ENOTFOUND error, get free port ${hostname}:${port}`)
                    resolve(port)
                    return
                }

                reject(err)
            })

            server.listen(port, hostname, () => {
                port = server.address().port
                server.close()

                console.log(`Found available port ${hostname}:${port}`)
                resolve(port)
            })
        })
    }
}

module.exports = new PortFinder()