const BaseAgent = require('./base')
const fileSystem = require('../filesystem')
const assets = require('../asset')

/**
 * Extractor Pond Agent.
 */

class Agent extends BaseAgent {
    async install () {
        return assets.getAssetsDir()

        // return fileSystem
        //     .copy('assets/agent/pond-extractor', fileInfo.path)
        //     .then(path => {
        //         this.textLog.addLine('Download complete')
        //         return path
        //     })
    }
}

module.exports = Agent