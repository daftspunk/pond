require('temp') // Without this the `temp` package won't be available for later nw.require call. nw.require is not available here yet.

const config = require('../config')
const fileSystem = require('../filesystem')

// TODO: downloads should be tracked with Google Analytics.
// TODO: edge installations should be possible too (see advanced options in the TODO list).

class Downloader {
    constructor (textLog) {
        this.textLog = textLog
    }

    async run () {
        const fs = nw.require('fs')
        const temp = nw.require('temp')

        // This will remove the temporary file on application exit
        temp.track()

        const fileInfo = temp.openSync('october-installer-archive')

        this.textLog.addLine('Downloading the installer...')

        // TODO: this is temporary
        // DEBUG
        if ( nw.require('process').env.X_LOCAL_DEBUG == 1 ) {
            return fileSystem
                .copy('/Users/alexeybobkov/tmp/october-installer.qs6hcl', fileInfo.path)
                .then(path => {
                    this.textLog.addLine('Download complete')
                    return path
                })
        }

        return new Promise((resolve, reject) => {
            var req = new XMLHttpRequest()

            // TODO: should allow edge installs, see notes
            req.open('GET', config.installerDownloadUrl.stable)

            req.onload = () => {
                if (req.status == 200) {
                    const bytes = req.getResponseHeader('Content-Length')
                    this.textLog.addLine('Download complete')

                    try {
                        fs.writeSync(fileInfo.fd, req.response)
                    }
                    catch (err) {
                        reject('Unable to save downloaded file')
                        fs.close(fileInfo.fd)
                        return
                    }

                    resolve(fileInfo.path)
                }
                else {
                    reject(this.textLog.addLine(`There was a download error. Status code: ${req.status}. ${req.responseText}`))
                }
            }

            req.onerror = () => {
                reject(this.textLog.addLine('Unable to download the installer: there was a network error. Please check your Internet connection.'))
            }

            req.send()
        })
    }

    cleanup () {

    }
}

module.exports = Downloader