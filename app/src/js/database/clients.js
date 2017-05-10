const Database = require('./')
const Projects = require('./projects')
const TYPE = 'client'

class ClientManager {
    list () {
        return new Promise((resolve, reject) => {
            Database.get().then((db) => {
                db.find({
                    selector: {
                        $and: [
                            {documentType: TYPE},
                            {name: {'$gte': null}}
                        ]
                    },
                    sort: ['name']
                })
                .then(resolve)
                .catch(reject)
            }).catch(reject)
        })
    }

    listClientsWithProjects () {
console.log('Loading clients with projects')
        return new Promise((resolve, reject) => {
            this.list().then((clients) => {
console.log(clients)
                clients.reduce((sequence, client) => {
                    return sequence.then(() => {
                        return this._loadProjectsForClient(client)
                    })
                }, Promise.resolve())
                .then(() => resolve(clients))
                .catch(reject)
            }).catch(reject)
        })
    }

    //
    // Private methods
    //

    _loadProjectsForClient (client) {
        const projects = Projects.getManager()

        return new Promise((resolve, reject) => {
            projects.listForClient(client._id).then((projects) => {
                client.projects = projects

                resolve()
            }).catch(reject)
        })
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