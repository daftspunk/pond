import Initializer from './initializer'
import environmentTypes from './types'
import platforms from './platforms'

// We must include all files statically, otherwise
// browserify won't compile them in the build.

// macOS

require('./servermanagers/pond/darwin')
require('./provisioners/pond/darwin')
require('./installers')

// require('./servermanagers/vagrant/darwin')
// require('./provisioners/vagrant/darwin')
// 
// require('./servermanagers/docker/darwin')
// require('./provisioners/docker/darwin')
// 
// require('./servermanagers/lamp/darwin')
// require('./provisioners/lamp/darwin')

// Windows

// require('./servermanagers/pond/win32')
// require('./provisioners/pond/win32')

// require('./servermanagers/vagrant/win32')
// require('./provisioners/vagrant/win32')
// 
// require('./servermanagers/docker/win32')
// require('./provisioners/docker/win32')
// 
// require('./servermanagers/lamp/win32')
// require('./provisioners/lamp/win32')

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

function getServerManagerClass(project, platform) {
    return requireWithCheck(
        './servermanagers/'+project.environmentType+'/'+platform,
        `Server manager for ${project.environmentType}/${platform} is not currently supported`
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
        './installers',
        `October installer for ${project.environmentType}/${platform} is not currently supported`
    )
}

function createInitializer(project) {
    const platform = platforms.getPlatform()

    if (!environmentTypes.isKnownEnvironment(project.environmentType)) {
        throw new Error('Unknown environment type')
    }

    if (!platforms.isSupportedPlatform(platform)) {
        throw new Error('Unsupported platform: '+platform)
    }

    const serverManagerClass = getServerManagerClass(project, platform)
    const provisionerClass = getProvisionerClass(project, platform)
    const installerClass = getInstallerClass(project, platform)

    return new Initializer(
        project,
        new serverManagerClass(project),
        new provisionerClass(project),
        new installerClass(project)
    )
}

export default {
    createInitializer
}