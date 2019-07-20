import fileSystem from '@app/utils/filesystem';
import followRedirects from 'follow-redirects';
import app from '@app/utils/app';
import config from '../../../config';

//
// API
//

const scriptName = 'pond-extractor.php';

export async function copyExtractor(websitePath) {
    const scriptSrc = app().distPath() + '/agent/pond-extractor.php';

    const scriptDest = websitePath + '/' + scriptName;

    await fileSystem.copy(scriptSrc, scriptDest);
}

export async function cleanupExtractor(websitePath) {
    const scriptDest = websitePath + '/' + scriptName;

    await fileSystem.unlink(scriptDest);
}

export function runExtractor(logger, localPort) {
    const net = window.require('electron').remote.net
    logger('Extracting the archive');

    return new Promise((resolve, reject) => {
        let request = net.request({
            method: 'POST',
            url: getLocalUrl(localPort) + '/' + scriptName
        })

        request
            .on('response', response => {
                response.on('data', (body) => {
                    var responseJson = null

                    try {
                        responseJson = JSON.parse(body)
                    }
                    catch (ex) {}

                    if (response.statusCode != 200) {
                        if (!responseJson) {
                            reject('Installation error. ' + body)
                        }
                        else {
                            reject(responseJson)
                            console.log(responseJson)
                        }

                        return
                    }

                    console.log(responseJson)

                    if (!responseJson || responseJson.status != 'DONE') {
                        reject('Invalid response received from the installer')
                        return
                    }

                    if (responseJson && responseJson.warnings && Object.getOwnPropertyNames(responseJson.warnings).length > 0) {
                        console.log(responseJson.warnings)
                        // this.project.runtime.warnings = responseJson.warnings
                    }

                    resolve()
                })

                response.on('error', (err) => {
                    reject(err)
                })
            })
            .on('error', err => {
                reject(err)
            })

        request.end()
    })
}

//
// Internals
//

function getLocalUrl(localPort) {
    return 'http://localhost:' + localPort;
}
