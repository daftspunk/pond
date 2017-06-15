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
 *    }
 * }
 */

const srcScriptName = 'pond-configurator.php'
const destScriptName = 'Plugin.php'

class Agent extends BaseAgent {
    async install () {
        const fs = nw.require('fs')
        const asssetsDir = assets.getAssetsDir()

        fs.mkdirSync(this.project.location + '/plugins/octoberpond')
        fs.mkdirSync(this.project.location + '/plugins/octoberpond/configurator')

        return fileSystem
            .copy(asssetsDir + '/agent/' + srcScriptName, this.project.location + '/plugins/octoberpond/configurator/' + destScriptName)
    }

    async uninstall () {
        const fs = nw.require('fs')

        console.log('Cleaning up the configurator')

        await fileSystem.unlink(this.project.location + '/plugins/octoberpond/configurator/' + destScriptName)
        fs.rmdirSync(this.project.location + '/plugins/octoberpond/configurator')

        const octoberPluginsPath = this.project.location + '/plugins/octoberpond'
        if (fileSystem.isDirectoryEmpty(octoberPluginsPath)) {
            fs.rmdirSync(octoberPluginsPath)
        }
    }

    async run (configuration) {
        this.project.initState.textLog.addLine('Configuring the installation')

        return new Promise((resolve, reject) => {
            request.post({url: this.localUrl + '/' + scriptName}, function callback(err, httpResponse, body) {
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