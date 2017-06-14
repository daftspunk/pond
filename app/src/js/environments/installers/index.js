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

    // Installation steps:
    //
    // 1. Install Extractor Pond Agent 
    // 2. Run Extractor
    // 3. Remove Extractor Agent | Call agent's cleanup here!
    // 4. If the server extractor to normal switch more requires 
    //    a restart - restart the server (only for Pond)
    // 5. Install Configurator Pond Agent
    // 6. Run Configurator
    // 7. Remove Agent | Call agent's cleanup here!

    async runExtractor (localUrl) {
        const extractorAgent = agentFactory.makeAgent(this.project, localUrl, agentFactory.EXTRACTOR)

        await extractorAgent.install()

        try {
            await extractorAgent.run()

            const configuratorAgent = agentFactory.makeAgent(this.project, localUrl, agentFactory.CONFIGURATOR)
            await configuratorAgent.install()

            try {

            }
            finally {
                await configuratorAgent.cleanup()
            }
        }
        finally {
            await extractorAgent.cleanup()
        }
    }
}

module.exports = Installer