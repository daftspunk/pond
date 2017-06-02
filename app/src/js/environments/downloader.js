require('temp') // Without this the `temp` package won't be available for later nw.require call. nw.require is not available here yet.

const url = 'https://octobercms.com/api/installer/stable'

// TODO: downloads should be tracked with Google Analytics.
// TODO: edge installations should be possible too (see advanced options in the TODO list).

class Downloader {
    constructor (textLog) {
        this.textLog = textLog
    }

    run () {
        const fs = nw.require('fs')
        const temp = nw.require('temp')

        // This will remove the temporary file on application exit
        temp.track()

        const fileInfo = temp.openSync('october-installer-archive')

        return new Promise((resolve, reject) => {
            var req = new XMLHttpRequest()

            req.open('GET', url)
            this.textLog.addLine('Downloading the installer...')

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