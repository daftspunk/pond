/**
 * Web server manager base class.
 *
 * In self-contained environments (Docker, Vagrant)
 * the manager should actually start/stop the environment.
 */

const EventEmitter = require('events').EventEmitter
const spawn = nw.require('child_process').spawn

class Manager extends EventEmitter {
    constructor (project) {
        super()

        this.serverProcess = null

        // Don't keep references to the project
        // itself

        this.location = project.location
    }

    start () {
        this.createChildProcess()

        this.emit('started')
    }

    stop () {
        if (this.serverProcess === null) {
            throw new Error('Server child process is already running')
        }

        this.serverProcess.kill()
    }

    getChildProcessArguments () {
        // TODO - the port should be dynamic
        return ['-S', 'localhost:8000', 'server.php']
    }

    getChildProcessOptions () {
        return {
            cwd: this.location
        }
    }

    getChildProcessCommand () {
        throw new Error('Implement getChildProcessCommand in a child server manager class')
    }

    createChildProcess () {
        if (this.serverProcess !== null) {
            throw new Error('Server child process is already running')
        }

        console.log('Spawning the server child process')

        this.serverProcess = spawn(
            this.getChildProcessCommand(),
            this.getChildProcessArguments(),
            this.getChildProcessOptions()
        )

        this.serverProcess.once('error', (err) => {
            console.log('Error in the server child process', err)

            this.serverProcess.kill()
            this.emit('error', err)
            this._cleanUp()
        })

        this.serverProcess.once('close', (code, signal) => {
            console.log('Closing the server child process')

            this._cleanUp()
            this.emit('stopped')
        })
    }

    //
    // Private methods
    //

    _cleanUp () {
        if (this.serverProcess === null) {
            throw new Error('Invalid cleanUp call - server child process is not running')
        }

        this.serverProcess.removeAllListeners(['error', 'close'])

        this.serverProcess = null
    }
}

module.exports = Manager