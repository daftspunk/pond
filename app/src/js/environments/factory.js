import Environment from './environment'
import environmentTypes from './types'
import platforms from './platforms'

// We must include all files statically, otherwise
// browserify won't compile them in the build.

// macOS

import ServerManagerPondDarwin from './servermanagers/pond/darwin'

// require('./servermanagers/vagrant/darwin')
// require('./servermanagers/docker/darwin')
// require('./servermanagers/lamp/darwin')

// Windows

// require('./servermanagers/pond/win32')
// require('./servermanagers/vagrant/win32')
// require('./servermanagers/docker/win32')
// require('./servermanagers/lamp/win32')

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

function createEnvironment(project) {
    const platform = platforms.getPlatform()

    if (!environmentTypes.isKnownEnvironment(project.environmentType)) {
        throw new Error('Unknown environment type')
    }

    if (!platforms.isSupportedPlatform(platform)) {
        throw new Error('Unsupported platform: '+platform)
    }

    const serverManagerClass = getServerManagerClass(project, platform)

    return new Environment(
        project,
        new serverManagerClass(project)
    )
}

export default {
    createEnvironment
}