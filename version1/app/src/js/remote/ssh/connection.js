import SSH from 'simple-ssh'

/**
 * Wrapper for the simple-ssh class. Logs all commands and adds a promise-friendly interface.
 */

class Connection {
    constructor (ip, privateKeyString, userName, stringMasks, connectionTimeoutSec, port) {
        this._ssh = new SSH({
            host: ip,
            user: userName,
            port: port === undefined ? 22 : port,
            timeout: connectionTimeoutSec === undefined ? 10000 : connectionTimeoutSec*1000,
            key: privateKeyString
        })

        this._makeMasks(stringMasks)
    }

    exec (command, variables) {
        var commandProcessed = ''

        return new Promise((resolve, reject) => {
            ssh.exec(commandProcessed, {
                exit: function(code, stdout, stderr) {
                    if (code !== 0) {
                        reject({stderr, stdout})
                        return
                    }

                    resolve(stdout)
                }
            }).start();
        })
    }

    execMultiple () {

    }

    _maskCommand (command) {
        var masks = Object.assign({}, this._stringMasks)
// Replace all occurincies of mask in the command
        $command = strtr($command, $masks);
        $command = preg_replace('/'.$this->termStr.'[0-9]+$/mD', '', $command);

        return trim($command);
    }

    _makeMasks (stringMasks) {
        this._stringMasks = []

        stringMasks.forEach(mask => {
            this._stringMasks[mask] = 'xxx'
        })
    }
}

export default Connection