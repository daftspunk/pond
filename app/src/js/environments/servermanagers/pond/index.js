const BaseManager = require('../')
const spawn = require('child_process').spawn

/**
 * Web server manager for Pond environment base class: 
 *
 *  - Pond built-in environment
 *  - PHP command-line server
 */

class Manager extends BaseManager {
    constructor (project) {
        super()

        this.serverProcess = null
        this.project = project
    }

    start () {
        this.createChildProcess()
    }

    stop () {
        if (this.serverProcess === null) {
            return
        }

        this.serverProcess.kill()
    }

    getChildProcessArguments () {
        // TODO - the port should be dynamic
        return ['-S', 'localhost:'+this.project.localPort, 'server.php']
    }

    getChildProcessOptions () {
        return {
            cwd: this.project.location
        }
    }

    getLocalUrl () {
        return 'http://localhost:'+this.project.localPort
    }

    createChildProcess () {
        if (this.serverProcess !== null) {
            throw new Error('Server child process is already running')
        }

        console.log('Spawning the server child process')

        const spawn = nw.require('child_process').spawn
        this.emit('start')

        this.serverProcess = spawn(
            this.getChildProcessCommand(),
            this.getChildProcessArguments(),
            this.getChildProcessOptions()
        )

        this.serverProcess.once('error', (err) => {
            console.log('Error in the server child process', err)

            this.stop()
            this.emit('log', err)
        })

        this.serverProcess.once('close', (code, signal) => {
            console.log('Closing the server child process')

            this._cleanUpServer()
            this.emit('stop')
        })

        this.serverProcess.stderr.on('data', (data) => {
            if (typeof data === 'string') {
                this.emit('log', data)
            }
            else {
                this.emit('log', data.toString('utf8'))
            }
        })
    }

    //
    // Private methods
    //

    _cleanUpServer () {
        if (this.serverProcess === null) {
            throw new Error('Invalid cleanUp call - server child process is not running')
        }

        console.log('Cleaning up the server manager')

        this.serverProcess.removeAllListeners(['error', 'close'])
        this.serverProcess.stderr.removeAllListeners(['data'])

        this.serverProcess = null
    }
}

module.exports = Manager