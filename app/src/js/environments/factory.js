const Environment = require('./environment')
const EnvironmentTypes = require('./types')
const Platforms = require('./platforms')

// We must include all files statically, otherwise browserify won't
// include them to the build
require('./webservermanagers/pond/darwin')
require('./dbservermanagers/pond/darwin')

function createEnvironment(project) {
    const platform = Platforms.getPlatform()

    if (!EnvironmentTypes.isKnownEnvironment(project.environmentType)) {
        throw new Error('Unknown environment type')
    }

    if (!Platforms.isSupportedPlatform(platform)) {
        throw new Error('Unsupported platform: '+platform)
    }

    const webServerClassPath = './webservermanagers/'+project.environmentType+'/'+platform
    const webServerManager = require(webServerClassPath)

    // PlatformTypes

    // project.environmentType

console.log(webServerManager)
    //return new Environment(webServerManager, dbServerManager, provisioner, installer)
}

module.exports = {
    createEnvironment
}