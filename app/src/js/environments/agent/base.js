/**
 * Base Pond Agent class
 */

class Agent {
    constructor (project) {
        this.project = project
    }

    async install () {
        throw new Error('Implement install() in a child Pond Agent class')
    }

    cleanup () {
        this.project = null
    }
}

module.exports = Agent