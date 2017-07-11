const path = require('path')

function getAssetsDir() {
    return path.dirname(process.execPath) + '/dist/assets'
}

function getPhpBinDir() {
    // TODO: this should return path to the packaged directory
    console.log(__dirname)
    return path.dirname(process.execPath) + '/src/assets-bin-php'
}

module.exports = {
    getAssetsDir,
    getPhpBinDir
}