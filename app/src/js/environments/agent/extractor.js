import BaseAgent from './base'
import fileSystem from '../../filesystem'
import assets from '../../assets'

/**
 * Extractor Pond Agent
 */

const scriptName = 'pond-extractor.php'

class Agent extends BaseAgent {
    async install () {
        const asssetsDir = assets.getAssetsDir()

        return fileSystem
            .copy(asssetsDir + '/agent/extractor/' + scriptName, this.project.location + '/' + scriptName)
    }

    async uninstall () {
        console.log('Cleaning up the extractor')

        return fileSystem
            .unlink(this.project.location + '/' + scriptName)
    }

    async run () {
        const request = nw.require('request')
        this.project.runtime.initState.textLog.addLine('Extracting the archive')

        return new Promise((resolve, reject) => {
            request.post({url: this.localUrl + '/' + scriptName}, (err, httpResponse, body) => {
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
                        reject(responseJson)
                        console.log(responseJson)
                    }

                    return
                }

                console.log(responseJson)

                if (!responseJson || responseJson.status != 'DONE') {
                    reject('Invalid response received from the installer')
                    return
                }

                if (responseJson && responseJson.warnings && Object.getOwnPropertyNames(responseJson.warnings).length > 0) {
                    this.project.runtime.warnings = responseJson.warnings
                }

                resolve()
            })
        })
    }
}

export default Agent