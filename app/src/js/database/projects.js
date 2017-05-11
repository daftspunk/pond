const Database = require('./')
const TYPE = 'project'

class ProjectManager {
    listForClient (clientId) {
        return Database.get()
            .then(db => db.find({
                    selector: {
                        documentType: TYPE,
                        name: {
                            $gt: null
                        },
                        clientId
                    },
                    sort: ['name']
                })
            )
            .then(result => result.docs)
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