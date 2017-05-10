const Database = require('./')
const TYPE = 'project'

class ProjectManager {
    listForClient (clientId) {
        return new Promise((resolve, reject) => {
            Database.get().then((db) => {
                db.find({
                    selector: {
                        documentType: TYPE,
                        name: {'$gte': null},
                        clientId
                    },
                    sort: ['name']
                })
                .then(resolve)
                .catch(reject)
            }).catch(reject)
        })
    }
}

var manager = null

function getManager() {
    if (manager === null) {
        manager = new ProjectManager()
    }

    return manager
}

module.exports = {
    getManager,
    type: TYPE
}