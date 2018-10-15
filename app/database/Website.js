import database from './'

const TYPE = 'website'

export default class Website {
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

    async create(website) {
        const db = await database.get()

        let objClone = Object.assign({}, website)
        objClone.documentType = TYPE
        delete objClone.runtime

        const putResult = await db.post(objClone)

        objClone._id = putResult.id
        objClone._rev = putResult.rev

        return objClone
    }
}
