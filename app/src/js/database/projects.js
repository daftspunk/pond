const Database = require('./')
const TYPE = 'project'

class ProjectManager {
    list () {
        return Database.get()
            .then(db => db.find({
                    selector: {
                        documentType: TYPE,
                        name: {
                            $gt: null
                        }
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