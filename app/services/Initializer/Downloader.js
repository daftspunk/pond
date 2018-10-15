import config from '../../config'
import fileSystem from '../../utils/filesystem';
import followRedirects from 'follow-redirects';

export default class Downloader {
    constructor (textLog, edgeUpdates) {
        this.textLog = textLog;
        this.edgeUpdates = edgeUpdates;
    }

    async run() {
        const client = followRedirects.https;
        const tmpFilePath = this.makeTmpFileName('october-installer-archive');

        this.textLog.addLine('Downloading the installer');

        var options = config.installerDownloadOptions.wizard;

        return new Promise((resolve, reject) => {
            const file = fileSystem.createWriteStream(tmpFilePath);

            const request = client.get(options);

            file.on('error', (err) => {
                reject('Unable to save downloaded file');
            })

            request.on('error', (err) => {
                reject('Unable to download the installer: there was a network error. Please check your Internet connection.');
            })

            request.on('response', (response) => {
                if (response.statusCode !== 200) {
                    reject(this.textLog.addLine(`There was a download error. Status code: ${response.statusCode}. ${response.statusMessage}`));
                    return;
                }

                response.on('data', (data) => {
                    file.write(data);
                })

                response.on('end', _ => {
                    file.end();
                    resolve(tmpFilePath);
                })

                response.on('error', (err) => {
                    reject('Unable to save downloaded file');
                })
            })
        })
    }

    cleanup() {
        this.textLog = null;
        console.log('Cleaning up the downloader');
    }

    makeTmpFileName(prefix) {
        function randomChars(count) {
            const chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
            var value = [];

            for (var i = 0; i < count; i++) {
                value.push(chars[Math.random(0, chars.length-1)]);
            }

            return value.join('');
        }

        const remote = window.require('electron').remote;
        var tmpDir = remote.require('os').tmpdir();

        return tmpDir + '/' + prefix + randomChars(12);
    }
}
