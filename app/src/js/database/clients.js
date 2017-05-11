const Database = require('./')
const Projects = require('./projects')
const TYPE = 'client'

class ClientManager {
    list () {
        return Database.get()
            .then(db => 
                db.find({
                    selector: {
// TODO - add doc type filter here
                        name: {
                            $gt: null
                        }
                    },
                    sort: ['name']
                })
            )
            .then(result => result.docs)
    }

    listClientsWithProjects () {
        return this.list()
            .then(clients =>
                clients.reduce(
                    (sequence, client) => sequence.then(_ => this._loadProjectsForClient(client)), 
                    Promise.resolve()
                )
                .then(_ => clients)
            )
    }

    //
    // Private methods
    //

    _loadProjectsForClient (client) {
        return Projects.getManager()
            .listForClient(client._id)
            .then(projects => client.projects = projects)
    }
}

var manager = null

function getManager() {
    if (manager === null) {
        manager = new ClientManager()
    }

    return manager
}

module.exports = {
    getManager,
    type: TYPE
}