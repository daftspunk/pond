module.exports = {
    installerDownloadOptions: {
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
    }
}