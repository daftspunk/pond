const Database = require('./')
const TYPE = 'project'

class ProjectManager {
    async list () {
        const db = await Database.get()

        const result = await db.find({
            selector: {
                documentType: TYPE,
                name: {
                    $gt: null
                }
            },
            sort: ['name']
        })

        return result.docs
    }

    async create (project) {
        const db = await Database.get()

        var projectClone = Object.assign({}, project)
        projectClone.documentType = TYPE
        delete projectClone.runtime
        
        const putResult = await db.post(projectClone)

        projectClone._id = putResult.id
        projectClone._rev = putResult.rev
        
        return projectClone
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