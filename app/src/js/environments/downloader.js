const temp = nw.require('temp')
const fs = nw.require('fs')

const url = 'https://github.com/octobercms/install/archive/master.zip'

// TODO: the download must go through our server with Google Analytics tracking.
// Use an URL parameter to mark the download as Pond download in the analytics.
// const url = 'https://octobercms.com/download/?pond=1'

class Downloader {
    constructor (textLog) {
        this.textLog = textLog
    }

    run () {
        // This will remove the temporary file on application exit
        temp.track()

        const fileInfo = temp.openSync('october-installer-archive')

        return new Promise((resolve, reject) => {
            var req = new XMLHttpRequest()

            req.open('GET', url)
            this.textLog.addLine('Downloading the installer...')

            req.onload = () => {
                if (req.status == 200) {
                    this.textLog.addLine('Download complete')
                    fs.writeSync(fileInfo.fd, req.response)
                    fs.close(fileInfo.fd)

                    resolve(fileInfo.path)
                }
                else {
                    this.textLog.addLine('There was a download error: '.req.statusText)
                    reject(req.statusText)
                }
            }

            req.onerror = () => {
                this.textLog.addLine('Unable to download the installer: there was a network error. Please check your Internet connection.')
                reject('Unable to download the installer: there was a network error. Please check your Internet connection.')
            }

            req.send()
        })
    }

    cleanup () {

    }
}

module.exports = Downloader