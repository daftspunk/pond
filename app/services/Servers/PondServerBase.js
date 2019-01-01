import ServerBase from './ServerBase';

/**
 * Web server manager for Pond environment base class: 
 *
 *  - Pond built-in environment
 *  - PHP command-line server
 */

export default class PondServerBase extends ServerBase {
    constructor(website) {
        super(website);

        this.serverProcess = null;

        // Determines if the server process was terminated
        // after receiving the 'close' event. If the server
        // is already running or the port is in use, the
        // waitWebServerStarted will resolve, but as the server
        // cannot be started, the terminated property will be
        // set by the `close` event handler.
        //
        // TODO: is it a best place to keep this state?
        //
        this.terminated = false;
    }

    async start() {
        return this.createChildProcess();
    }

    async stop() {
        if (this.serverProcess === null) {
            return;
        }

        this.serverProcess.kill();

        this.emit('log', 'Stopping the server...');

        await this.waitWebServerStopped();

        this.emit('log', 'Server has stopped');
    }

    getChildProcessArguments() {
        // TODO - the port should be dynamic

        if (!this.extractorMode) {
            return ['-S', 'localhost:'+this.website.localPort, 'server.php'];
        }
        else {
            return ['-S', 'localhost:'+this.website.localPort];
        }
    }

    getChildProcessOptions() {
        return {
            cwd: this.website.location
        };
    }

    getLocalUrl() {
        return 'http://localhost:' + this.website.localPort;
    }

    getServerStartTimeout() {
        return 1000;
    }

    getServerStopTimeout() {
        return 1000;
    }

    getSwitchFromExtractorRequiresRestart() {
        return true;
    }

    async createChildProcess() {
        if (this.serverProcess !== null) {
            throw new Error('Server child process is already running');
        }

        console.log('Spawning the server child process');

        const remote = window.require('electron').remote;
        const { spawn } = remote.require('child_process');

        console.log('Spawn ',
            this.getChildProcessCommand(),
            this.getChildProcessArguments(),
            this.getChildProcessOptions()
        )

        this.serverProcess = spawn(
            this.getChildProcessCommand(),
            this.getChildProcessArguments(),
            this.getChildProcessOptions()
        );

        this.serverProcess.once('close', (code, signal) => {
            console.log('Closing the server child process');

            this._cleanUpServer();
            this.emit('stop');
            this.terminated = true;
        });

        this.serverProcess.stderr.on('data', (data) => {
            if (typeof data === 'string') {
                this.emit('log', data);
            }
            else {
                this.emit('log', data.toString('utf8'));
            }
        });

        this.serverProcess.once('error', (err) => {
            console.log('Error in the server child process', err);

            this.stop();
            this.emit('log', err);
        });

        this.emit('log', 'Waiting for the server...');

        this.terminated = false;

        return new Promise((resolve, reject) => {
            this.waitWebServerStarted()
                .then(_ => {
                    if (!this.terminated) {
                        this.emit('start');
                        this.emit('log', 'Server is ready');
                        resolve();
                    }
                    else {
                        reject('The server process was terminated');
                    }
                })
                .catch(err => {
                    this.emit('log', 'Cannot start the server');
                    if (typeof err === 'string') {
                        this.emit('log', err);
                    }
                    reject(err);
                })
        })
    }

    //
    // Private methods
    //

    _cleanUpServer() {
        if (this.serverProcess === null) {
            throw new Error('Invalid cleanUp call - server child process is not running');
        }

        console.log('Cleaning up the server manager');

        this.serverProcess.removeAllListeners(['error', 'close']);
        this.serverProcess.stderr.removeAllListeners(['data']);

        this.serverProcess = null;
    }
}
