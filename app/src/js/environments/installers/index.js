/**
 * Installer. It doesn't look like we are going to have 
 * individual installer classes for different environments
 * and platforms. The installer uses Pond Agent to extract
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
        // 3. Remove Extractor Agent
        // 4. Install Configurator Pond Agent
        // 5. Run Configurator
        // 6. Remove Agent
    }
}

module.exports = Installer