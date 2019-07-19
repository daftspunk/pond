import Initializer from './initializer'
import environmentTypes from './types'
import platforms from './platforms'

// We must include all files statically, otherwise
// browserify won't compile them in the build.

// macOS

import ServerManagerPondDarwin from './servermanagers/pond/darwin'
import ProvisionerPondDarwin from './provisioners/pond/darwin'
import Installer from './installers'

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
    if (project.environmentType == 'pond' && platform == 'darwin') {
        return ServerManagerPondDarwin
    }

    const errorString = `Server manager for ${project.environmentType}/${platform} is not currently supported`
    throw new Error(errorString)
}

function getProvisionerClass(project, platform) {
    if (project.environmentType == 'pond' && platform == 'darwin') {
        return ProvisionerPondDarwin
    }

    const errorString = `Environment provisioner for ${project.environmentType}/${platform} is not currently supported`
    throw new Error(errorString)
}

function getInstallerClass(project, platform) {
    if (project.environmentType == 'pond' && platform == 'darwin') {
        return Installer
    }

    const errorString = `October installer for ${project.environmentType}/${platform} is not currently supported`
    throw new Error(errorString)
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