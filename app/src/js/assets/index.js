const path = require('path')

function getAssetsDir() {
    return path.dirname(process.execPath) + '/dist/assets'
}

module.exports = {
    getAssetsDir
}