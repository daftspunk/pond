const agentFactory = require('../agent')

/**
 * It doesn't look like we are going to have individual
 * installer classes for different environments and 
 * platforms. The installer uses Pond Agent to extract
 * the archive.
 */

class Installer {
    constructor (project) {
        this.project = project
    }

    async run () {
        // Installation steps:
        //
        // 1. Install Extractor Pond Agent 
        // 2. Run Extractor
        // 3. Remove Extractor Agent | Call agent's cleanup here!
        // 4. Install Configurator Pond Agent
        // 5. Run Configurator
        // 6. Remove Agent | Call agent's cleanup here!

        const extractorAgent = agentFactory.makeAgent(agentFactory.ECTRACTOR)

        await extractorAgent.install()

    }
}

module.exports = Installer