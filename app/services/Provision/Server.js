import { getPhpBinDir } from '../../utils/assets'
import platforms from '../../utils/platforms'
import { resolve } from 'path'

//
// API
//

export function newServer(websitePath, localPort, logger, serverMode=true) {
    return new Server({ websitePath, localPort, logger, serverMode });
}

class Server {
    constructor({ websitePath, localPort, logger, serverMode }) {
        this.websitePath = websitePath;
        this.localPort = localPort;
        this.logger = logger;
        this.serverMode = serverMode;

        this.serverProcess = null;
        this.terminated = false;
    }

    async start() {
        if (this.serverProcess !== null) {
            throw new Error('Server child process is already running');
        }

        const remote = window.require('electron').remote;
        const { spawn } = remote.require('child_process');

        const childProcessOptions = { cwd: this.websitePath }

        const childProcessArguments = this.serverMode
            ? ['-S', 'localhost:'+this.localPort, 'server.php']
            : ['-S', 'localhost:'+this.localPort]

        this.serverProcess = spawn(
            this.getChildProcessCommand(),
            childProcessArguments,
            childProcessOptions
        );

        this.serverProcess.once('close', (code, signal) => {
            console.log('Closing the server child process');

            this.cleanUpServer();
            this.terminated = true;
        });

        this.serverProcess.stderr.on('data', (data) => {
            if (typeof data === 'string') {
                this.log(data);
            }
            else {
                this.log(data.toString('utf8'));
            }
        });

        this.serverProcess.once('error', (err) => {
            console.log('Error in the server child process', err);

            this.stop();

            this.log(err);
        });

        this.log('Waiting for the server...')

        this.terminated = false

        return new Promise((resolve, reject) => {
            this.waitWebServerStarted()
                .then(_ => {
                    if (!this.terminated) {
                        this.log('Server is ready');
                        resolve();
                    }
                    else {
                        reject('The server process was terminated');
                    }
                })
                .catch(err => {
                    this.log('Cannot start the server');
                    if (typeof err === 'string') {
                        this.log(err);
                    }
                    reject(err);
                })
        })
    }

    async stop() {
        if (this.serverProcess === null) {
            return;
        }

        this.serverProcess.kill();

        this.log('Stopping the server...');

        this.waitWebServerStopped();

        this.log('Server has stopped');
    }

    //
    // Internals
    //

    log(message) {
        this.logger(message);
    }

    waitWebServerStarted() {
        return this.makeTestRequest(1000, true);
    }

    waitWebServerStopped() {
        return this.makeTestRequest(1000, false);
    }

    getLocalUrl() {
        return 'http://localhost:' + this.localPort;
    }

    getChildProcessCommand() {
        const platform = platforms.getPlatform();

        if (platform == 'darwin') {
            return resolve(getPhpBinDir()) + '/darwin/bin/php';
        }

        if (platform == 'win32') {
            return resolve(getPhpBinDir()) + '/win32/php.exe';
        }

        return resolve(getPhpBinDir()) + '/win32/php.exe';
    }

    cleanUpServer() {
        if (this.serverProcess === null) {
            throw new Error('Invalid cleanUp call - server child process is not running');
        }

        console.log('Cleaning up the server manager');

        this.serverProcess.removeAllListeners(['error', 'close']);
        this.serverProcess.stderr.removeAllListeners(['data']);

        this.serverProcess = null;
    }

    makeTestRequest(timeout, waitForStart) {
        const currentTime = new Date().getTime();
        const endTime = currentTime + timeout;
        const connectionTimeout = 200;
        const retryInterval = 300;
        const net = window.require('electron').remote.net;

        // TODO: check if the error 500 is considered
        // as a running state (it must be so)

        return new Promise((resolve, reject) => {
            var doRequest = () => {
                console.log('Pinging the server...' + this.getLocalUrl());

                let request = net.request({
                    method: 'GET',
                    url: this.getLocalUrl(),
                    timeout: connectionTimeout
                });

                request
                    .on('response', response => {
                        console.log('Server response received');

                        if (waitForStart) {
                            resolve();
                        }
                        else {
                            nextOrReject();
                        }
                    })
                    .on('error', err => {
                        console.log('Error received', err);

                        if (waitForStart) {
                            nextOrReject();
                        }
                        else {
                            resolve();
                        }

                        // if (err.code === 'ETIMEDOUT') {
                        //     // Wait more...
                        // }
                    })

                request.end();
            }

            var nextOrReject = () => {
                if (new Date().getTime() < endTime) {
                    setTimeout(doRequest, retryInterval);
                    return;
                }
                else {
                    reject(waitForStart
                        ? 'Server manager could not start the environment.'
                        : 'Server manager could not stop the environment.'
                    );
                }
            }

            doRequest();
        });

    }
}
