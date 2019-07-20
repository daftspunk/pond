import fileSystem from '@app/utils/filesystem';
import followRedirects from 'follow-redirects';
import app from '@app/utils/app';
import config from '../../../config';

//
// API
//

export async function downloadInstaller(websitePath) {
    const client = followRedirects.https;

    const tmpFilePath = makeTmpFileName('october-installer-archive');

    var options = config.installerDownloadOptions.wizard;

    await new Promise((resolve, reject) => {
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

    const destination = websitePath + '/installer.pak';

    try {
        await fileSystem.copy(tmpFilePath, destination);
    }
    finally {
        fileSystem.unlinkSync(tmpFilePath);
    }

    return destination;
}

export async function cleanupInstaller(websitePath) {
    const destination = websitePath + '/installer.pak';

    await fileSystem.unlink(destination);
}

//
// Internals
//

function makeTmpFileName(prefix) {
    function randomChars(count) {
        const chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
        var value = [];

        for (var i = 0; i < count; i++) {
            value.push(chars[Math.random(0, chars.length-1)]);
        }

        return value.join('');
    }

    var tmpDir = app().tempPath();

    return tmpDir + '/' + prefix + randomChars(12);
}
