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
    // 3. Remove Extractor Agent
    // 4. If the server extractor to normal switch more requires 
    //    a restart - restart the server (only for Pond), see
    //    also note in Initializer.js
    // 5. Install Configurator Pond Agent
    // 6. Run Configurator
    // 7. Remove Agent

    async run (serverManager, configuration) {
        const localUrl = serverManager.getLocalUrl()
        const extractorAgent = agentFactory.makeAgent(this.project, localUrl, agentFactory.EXTRACTOR)

        await extractorAgent.install()

        try {
            await extractorAgent.run()

            const configuratorAgent = agentFactory.makeAgent(this.project, localUrl, agentFactory.CONFIGURATOR)
console.log('Installing...')
            await configuratorAgent.install()
console.log('Installing done')
            serverManager.setExtractorModeOff()
            if (serverManager.getSwitchFromExtractorRequiresRestart()) {
console.log('Restarting')
                await serverManager.restart()
console.log('Restarting done')
            }

            try {
console.log('Configuring')
                configuratorAgent.run(configuration)
console.log('Configuring done')
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