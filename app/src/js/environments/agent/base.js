/**
 * Base Pond Agent class
 */

class Agent {
    constructor (project, localUrl) {
        this.project = project
        this.localUrl = localUrl
    }

    async install () {
        throw new Error('Implement install() in a child Pond Agent class')
    }

    async uninstall () {
        throw new Error('Implement uninstall() in a child Pond Agent class')
    }

    async cleanup () {
        await this.uninstall()
        this.project = null
    }
}

export default Agent