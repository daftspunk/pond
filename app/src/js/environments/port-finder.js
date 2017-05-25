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
        return projects.some(project => project.localPort == port)
    }
}

module.exports = new PortFinder()