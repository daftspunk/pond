export default {
    installerDownloadOptions: {
        wizard: {
            hostname: 'github.com',
            // If changed to 80, the downloader class should be updated
            // to use 'http' instead of 'https' class.
            port: 443,
            path: '/octobercms/install/archive/master.zip',
            method: 'GET',
            redirect: 'follow'
        },
        stable: {
            hostname: 'octobercms.com',
            // If changed to 80, the downloader class should be updated
            // to use 'http' instead of 'https' class.
            port: 443,
            path: '/api/installer/stable',
            method: 'GET',
            headers: {
                'User-Agent': 'OctoberCMS Installer; Pond'
            }
        },
        edge: {
            hostname: 'octobercms.com',
            // If changed to 80, the downloader class should be updated
            // to use 'http' instead of 'https' class.
            port: 443,
            path: '/api/installer/edge',
            method: 'GET',
            headers: {
                'User-Agent': 'OctoberCMS Installer; Pond'
            }
        }
    },
    builtInServerInfo: {
        darwin: {
            php: {
                version: '7.1'
            }
        }
    },
    getPondEnvironmentName: function() {
        if (process.env.NODE_ENV !== undefined) {
            return process.env.NODE_ENV;
        }

        return 'production';
    }
}
