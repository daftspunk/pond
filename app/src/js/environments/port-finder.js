class PortFinder {
    constructor () {
        
    }

    getNextPort (projects) {
        var startingPort = 8080

        for (var port = startingPort; port <= 65535; port++) {
            if (!projects.some(project => project.localPort == port)) {
                return port
            }
        }

        return 65535
    }
}

module.exports = new PortFinder()