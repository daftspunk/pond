import database from './'

const TYPE = 'project'

export default class Project {
    async list() {
        const db = await database.get()

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

    async create(project) {
        const db = await database.get()

        var objClone = Object.assign({}, project)
        objClone.documentType = TYPE
        delete objClone.runtime

        const putResult = await db.post(objClone)

        objClone._id = putResult.id
        objClone._rev = putResult.rev

        return objClone
    }
}
