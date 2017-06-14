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
        console.log('Cleaning up the extractor')

        return fileSystem
            .unlink(this.project.location + '/' + scriptName)
    }

    async run () {
        this.project.initState.textLog.addLine('Extracting the archive')

        return new Promise((resolve, reject) => {
            request.post({url: this.localUrl + '/' + scriptName}, function callback(err, httpResponse, body) {
                if (err) {
                    reject(err)
                }

                var responseJson = null

                try {
                    responseJson = JSON.parse(body)
                }
                catch (ex) {}

                if (httpResponse.statusCode != 200) {
                    if (!responseJson) {
                        reject('Installation error. ' + body)
                    }
                    else {
                        // TODO - show a formatted list of errors
                        // and warnings here
                        reject('Installation error.')
                        console.log(responseJson)
                    }

                    return
                }

                if (body !== 'DONE') {
                    reject('Invalid response received from the installer')
                    return
                }

                resolve()
            })
        })
    }
}

module.exports = Agent