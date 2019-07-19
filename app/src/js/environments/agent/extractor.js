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
        const net = require('electron').remote.net
        this.project.runtime.initState.textLog.addLine('Extracting the archive')

        return new Promise((resolve, reject) => {
            let request = net.request({
                method: 'POST',
                url: this.localUrl + '/' + scriptName
            })

            request
                .on('response', response => {
                    response.on('data', (body) => {
                        var responseJson = null

                        try {
                            responseJson = JSON.parse(body)
                        }
                        catch (ex) {}

                        if (response.statusCode != 200) {
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

                    response.on('error', (err) => {
                        reject(err)
                    })
                })
                .on('error', err => {
                    reject(err)
                })

            request.end()
        })
    }
}

export default Agent
