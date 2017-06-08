const BaseAgent = require('./base')
const fileSystem = require('../../filesystem')
const assets = require('../../assets')

/**
 * Extractor Pond Agent
 */

class Agent extends BaseAgent {
    async install () {
        const asssetsDir = assets.getAssetsDir()

        // TODO - properly handle then/catch here

        return fileSystem
            .copy(asssetsDir + '/agent/pond-extractor.php', fileInfo.path)
            .then(path => {
                this.project.textLog.addLine('Download complete')
                return path
            })
    }
}

module.exports = Agent