import config from '../config'
import fileSystem from '../filesystem'

// TODO: downloads should be tracked with Google Analytics.

class Downloader {
    constructor (textLog, edgeUpdates) {
        this.textLog = textLog
        this.edgeUpdates = edgeUpdates
    }

    async run () {
        const fs = require('fs')
        const client = require('follow-redirects').https
        const tmpFilePath = fileSystem.makeTmpFileName('october-installer-archive')

        this.textLog.addLine('Downloading the installer')

        var options = config.installerDownloadOptions.wizard

        return new Promise((resolve, reject) => {
            const file = fs.createWriteStream(tmpFilePath)

            const request = client.get(options)

            file.on('error', (err) => {
                reject('Unable to save downloaded file')
            })

            request.on('error', (err) => {
                reject('Unable to download the installer: there was a network error. Please check your Internet connection.')
            })

            request.on('response', (response) => {
                if (response.statusCode !== 200) {
                    reject(this.textLog.addLine(`There was a download error. Status code: ${response.statusCode}. ${response.statusMessage}`))
                    return
                }

                response.on('data', (data) => {
                    file.write(data)
                })

                response.on('end', _ => {
                    file.end()
                    resolve(tmpFilePath)
                })

                response.on('error', (err) => {
                    reject('Unable to save downloaded file')
                })
            })
        })
    }

    cleanup () {
        this.textLog = null
        console.log('Cleaning up the downloader')
    }
}

export default Downloader
