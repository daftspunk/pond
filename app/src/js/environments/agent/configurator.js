const BaseAgent = require('./base')
const fileSystem = require('../../filesystem')
const assets = require('../../assets')
const request = require('request')

/**
 * Configurator Pond Agent
 *
 * plugins
 *   octoberpond
 *     configurator
 *        Plugin.php
 *        routes.php
 *
 * Payload expected by the PHP side:
 * {
 *    database: {
 *        default: "sqlite",
 *
 *        # Omitted for sqlite:
 *        connection: { 
 *            database: "",
 *            username: "",
 *            password: "",
 *            port: ""
 *        }
 *    },
 *    
 *    # Optional 
 *    encryptionKey: ""
 * }
 */

class Agent extends BaseAgent {
    async install () {
        const fs = nw.require('fs')
        const asssetsDir = assets.getAssetsDir()

        fs.mkdirSync(this.project.location + '/plugins/octoberpond')
        fs.mkdirSync(this.project.location + '/plugins/octoberpond/configurator')

        await fileSystem.copy(asssetsDir + '/agent/configurator/Plugin.php', this.project.location + '/plugins/octoberpond/configurator/Plugin.php')
        await fileSystem.copy(asssetsDir + '/agent/configurator/routes.php', this.project.location + '/plugins/octoberpond/configurator/routes.php')
    }

    async uninstall () {
        const fs = nw.require('fs')

        console.log('Cleaning up the configurator')

        await fileSystem.unlink(this.project.location + '/plugins/octoberpond/configurator/Plugin.php')
        await fileSystem.unlink(this.project.location + '/plugins/octoberpond/configurator/routes.php')

        fs.rmdirSync(this.project.location + '/plugins/octoberpond/configurator')

        const octoberPluginsPath = this.project.location + '/plugins/octoberpond'
        if (fileSystem.isDirectoryEmpty(octoberPluginsPath)) {
            fs.rmdirSync(octoberPluginsPath)
        }
    }

    async run (configuration) {
        this.project.initState.textLog.addLine('Configuring the installation')

        const fields = {
            payload: JSON.stringify(configuration)
        }
console.log(configuration)
        return new Promise((resolve, reject) => {
            request.post({url: this.localUrl + '/pond/configure', form: fields}, function callback(err, httpResponse, body) {
console.log(body)
                if (err) {
                    reject(err)
                }

                if (httpResponse.statusCode != 200) {
                    if (!responseJson) {
                        reject('Configuration error. ' + body)
                    }

                    return
                }

                if (body !== 'DONE') {
                    reject('Invalid response received from the configurator')
                    return
                }

                resolve()
            })
        })
    }
}

module.exports = Agent