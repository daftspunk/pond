const ExtractorAgent = require('./extractor')

/**
 * Pond Agent performs operations in October installations on behalf of Pond.
 * It accepts POST requests from the local machine. The Agent is installed
 * only when it's needed and removed after it finishes its work.
 *
 * One of the design goals for the Agent is that it should consist of as
 * few files as possible, because of the complexity of filesystem operations
 * in context of nw.js.
 */

const EXTRACTOR = 'extractor'
const CONFIGURATOR = 'configurator'

function makeAgent(project, localUrl, type) {
    if (type != EXTRACTOR && type != CONFIGURATOR) {
        throw new Error(`Unknown Pond Agent type: ${this.type}`)
    }

    if (type == EXTRACTOR) {
        return new ExtractorAgent(project, localUrl)
    }
}

module.exports = {
    makeAgent,
    EXTRACTOR,
    CONFIGURATOR
}