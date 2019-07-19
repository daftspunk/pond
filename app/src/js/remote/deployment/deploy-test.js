class DeployTest {
    constructor () {
        
    }

    deploy () {
        const { Client } = require('ssh2')
        const fs = require('fs')

        return new Promise((resolve, reject) => {
            var conn = new Client()
            conn.on('ready', function () {
                conn.exec('uptime', function (err, stream) {
                    if (err) throw err
                    stream.on('close', function (code, signal) {
                        conn.end()
                        resolve('Stream :: close :: code: ' + code + ', signal: ' + signal)
                    }).on('data', function (data) {
//                        console.log('STDOUT: ' + data)
                    }).stderr.on('data', function (data) {
//                        console.log('STDERR: ' + data)
                    })
                })
            })
            conn.connect({
                host: '192.168.33.10',
                port: 22,
                username: 'deploy',
                privateKey: fs.readFileSync('/Users/alexeybobkov/October/pond/pond/target-server-dev-environment/keys/id_rsa')
            })
        })
    }
}

export default DeployTest