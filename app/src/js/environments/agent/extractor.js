const BaseAgent = require('./base')
const fileSystem = require('../../filesystem')
const assets = require('../../assets')
const request = require('request')

/**
 * Extractor Pond Agent
 */

const scriptName = 'pond-extractor.php'

class Agent extends BaseAgent {
    async install () {
        const asssetsDir = assets.getAssetsDir()

        return fileSystem
            .copy(asssetsDir + '/agent/' + scriptName, this.project.location + '/' + scriptName)
    }

    async uninstall () {
        return fileSystem
            .unlink(this.project.location + '/' + scriptName)
    }

    async run () {
        return new Promise((resolve, reject) => {
            request.post({url: this.localUrl + '/' + scriptName}, function callback(err, httpResponse, body) {
                if (err) {
                    reject(err)
                }

                if (httpResponse.statusCode != 200) {
                    reject('Invalid installer response code: ' + httpResponse.statusCode)
                }

                if (body !== 'DONE') {
                    reject('Invalid response received from the installer')
                }

                resolve()
            })
        })
    }
}

module.exports = Agent