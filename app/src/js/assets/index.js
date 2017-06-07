const path = require('path')

function getAssetsDir() {
    return path.dirname(process.execPath)
}

module.exports = {
    getAssetsDir
}