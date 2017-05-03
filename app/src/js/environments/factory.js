const Environment = require('./environment')
const EnvironmentTypes = require('./types')
const Platforms = require('./platforms')

// We must include all files statically, otherwise
// browserify won't compile them in the build.

// macOS

require('./webservermanagers/pond/darwin')
require('./dbservermanagers/pond/darwin')
require('./provisioners/pond/darwin')
require('./installers/pond/darwin')

// require('./webservermanagers/vagrant/darwin')
// require('./dbservermanagers/vagrant/darwin')
// require('./provisioners/vagrant/darwin')
// require('./installers/vagrant/darwin')
// 
// require('./webservermanagers/docker/darwin')
// require('./dbservermanagers/docker/darwin')
// require('./provisioners/docker/darwin')
// require('./installers/docker/darwin')
// 
// require('./webservermanagers/lamp/darwin')
// require('./dbservermanagers/lamp/darwin')
// require('./provisioners/lamp/darwin')
// require('./installers/lamp/darwin')

// Windows

// require('./webservermanagers/pond/win32')
require('./dbservermanagers/pond/win32')
// require('./provisioners/pond/win32')
// require('./installers/pond/win32')

// require('./webservermanagers/vagrant/win32')
// require('./dbservermanagers/vagrant/win32')
// require('./provisioners/vagrant/win32')
// require('./installers/vagrant/win32')
// 
// require('./webservermanagers/docker/win32')
// require('./dbservermanagers/docker/win32')
// require('./provisioners/docker/win32')
// require('./installers/docker/win32')
// 
// require('./webservermanagers/lamp/win32')
// require('./dbservermanagers/lamp/win32')
// require('./provisioners/lamp/win32')
// require('./installers/lamp/win32')

function requireWithCheck(path, errorString) {
    try {
        return require(path)
    }
    catch (err) {
        if (err.code === 'MODULE_NOT_FOUND') {
            throw new Error(errorString)
        }

        throw err
    }
}

function getWebServerManagerClass(project, platform) {
    return requireWithCheck(
        './webservermanagers/'+project.environmentType+'/'+platform,
        `Web server manager for ${project.environmentType}/${platform} is not currently supported`
    )
}

function getDbServerManagerClass(project, platform) {
    return requireWithCheck(
        './dbservermanagers/'+project.environmentType+'/'+platform,
        `Database server manager for ${project.environmentType}/${platform} is not currently supported`
    )
}

function getProvisionerClass(project, platform) {
    return requireWithCheck(
        './provisioners/'+project.environmentType+'/'+platform,
        `Environment provisioner for ${project.environmentType}/${platform} is not currently supported`
    )
}

function getInstallerClass(project, platform) {
    return requireWithCheck(
        './installers/'+project.environmentType+'/'+platform,
        `October installer for ${project.environmentType}/${platform} is not currently supported`
    )
}

function createEnvironment(project) {
    const platform = Platforms.getPlatform()

    if (!EnvironmentTypes.isKnownEnvironment(project.environmentType)) {
        throw new Error('Unknown environment type')
    }

    if (!Platforms.isSupportedPlatform(platform)) {
        throw new Error('Unsupported platform: '+platform)
    }

    const webServerManagerClass = getWebServerManagerClass(project, platform)
    const dbServerManagerClass = getDbServerManagerClass(project, platform)
    const provisionerClass = getProvisionerClass(project, platform)
    const installerClass = getInstallerClass(project, platform)

    return new Environment(
        project,
        new webServerManagerClass(project),
        new dbServerManagerClass(project),
        new provisionerClass(project),
        new installerClass(project)
    )
}

module.exports = {
    createEnvironment
}