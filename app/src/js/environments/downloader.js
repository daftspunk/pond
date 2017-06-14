require('temp') // Without this the `temp` package won't be available for later nw.require call. nw.require is not available here yet.

const config = require('../config')
const fileSystem = require('../filesystem')

// TODO: downloads should be tracked with Google Analytics.

class Downloader {
    constructor (textLog) {
        this.textLog = textLog
    }

    async run () {
        const fs = nw.require('fs')
        const client = nw.require('https')
        const temp = nw.require('temp')

        // This will remove the temporary file on application exit
        temp.track()

        const fileInfo = temp.openSync('october-installer-archive')

        this.textLog.addLine('Downloading the installer')

        // TODO: this is temporary
        // DEBUG
        if ( nw.require('process').env.X_LOCAL_DEBUG == 1 ) {
            return fileSystem
                .copy('/Users/alexeybobkov/tmp/installer.pak', fileInfo.path)
                .then(path => {
                    return path
                })
        }

        // TODO: edge installations should be possible too (see advanced options in the TODO list).
        const options = config.installerDownloadOptions.stable

        return new Promise((resolve, reject) => {
            const file = fs.createWriteStream(fileInfo.path)

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
                    resolve(fileInfo.path)
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

module.exports = Downloader