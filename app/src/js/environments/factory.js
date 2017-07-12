const Environment = require('./environment')
const EnvironmentTypes = require('./types')
const platforms = require('./platforms')

// We must include all files statically, otherwise
// browserify won't compile them in the build.

// macOS

require('./servermanagers/pond/darwin')

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
    return requireWithCheck(
        './servermanagers/'+project.environmentType+'/'+platform,
        `Server manager for ${project.environmentType}/${platform} is not currently supported`
    )
}

function createEnvironment(project) {
    const platform = platforms.getPlatform()

    if (!EnvironmentTypes.isKnownEnvironment(project.environmentType)) {
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

module.exports = {
    createEnvironment
}