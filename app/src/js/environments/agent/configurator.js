import BaseAgent from './base'
import fileSystem from '../../filesystem'
import assets from '../../assets'
import projectDefaults from '../../stores/projects/defaults'

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
        const fs = require('fs')
        const asssetsDir = assets.getAssetsDir()

        fs.mkdirSync(this.project.location + '/plugins/octoberpond')
        fs.mkdirSync(this.project.location + '/plugins/octoberpond/configurator')

        await fileSystem.copy(asssetsDir + '/agent/configurator/Plugin.php', this.project.location + '/plugins/octoberpond/configurator/Plugin.php')
        await fileSystem.copy(asssetsDir + '/agent/configurator/routes.php', this.project.location + '/plugins/octoberpond/configurator/routes.php')
    }

    async uninstall () {
        const fs = require('fs')
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
        this.project.runtime.initState.textLog.addLine('Configuring the installation')

        const request = require('request')
        var filteredConfiguration = Object.assign({}, configuration)

        if (!filteredConfiguration.useAdvancedOptions) {
            Object.assign(filteredConfiguration, projectDefaults.advancedOptions)
        }

        const fields = {
            payload: JSON.stringify(filteredConfiguration)
        }

        return new Promise((resolve, reject) => {
            request.post(this.localUrl + '/pond/configure', function callback(err, httpResponse, body) {
                if (err) {
                    reject(err)
                    return
                }

                if (httpResponse.statusCode != 200) {
                    reject('Configuration error. ' + body)
                    return
                }

                if (body !== 'DONE') {
                    reject('Invalid response received from the configurator')
                    return
                }

                resolve()
            }).form(fields)
        })
    }
}

export default Agent
