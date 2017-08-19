const SSH = require('node-sshclient').SSH

class DeployTest {
    constructor () {
        
    }

    deploy () {
        // const conn = new Client()

        // .connect({
        //   host: '192.168.33.10',
        //   username: 'deploy'
        // });

        const ssh = new SSH({
            host: '192.168.33.10',
            user: 'deploy'
        });

        ssh.command('echo', 'test', function(procResult) {
            console.log(procResult.stdout);
        });
    }
}

module.exports = DeployTest