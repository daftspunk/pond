import agentFactory from '../agent'

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

    //-----------------
    // IMPORTANT NOTE: The configuratorAgent was originally used to manipulate
    // October's config files as part of the install, but now it uses the
    // wizard installer for simplicity. The configuratorAgent is kept here
    // because it may be useful to repurpose it for customising the actual
    // installer instead. i.e presetting values
    //-----------------

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

            // const configuratorAgent = agentFactory.makeAgent(this.project, localUrl, agentFactory.CONFIGURATOR)
            // await configuratorAgent.install()

            serverManager.setExtractorModeOff()
            if (serverManager.getSwitchFromExtractorRequiresRestart()) {
                await serverManager.restart()
            }

            // try {
            //     await configuratorAgent.run(configuration)
            // }
            // finally {
            //     await configuratorAgent.cleanup()
            // }
        }
        finally {
            await extractorAgent.cleanup()
        }
    }
}

export default Installer
