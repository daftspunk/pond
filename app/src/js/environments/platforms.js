const Os = require('os')

const platforms = [
    'darwin',
    'win32'
]

function typeToString(type) {
    if (!types.includes(type)) {
        return 'projects.platform_type.unknown'
    }

    return 'projects.platform_type.'+type
}

function getPlatform() {
    // Not sure if it's a best way to detect the platform.
    // os.platform is "browser" in nw.js. process.platform
    // is undefined.

    const release = Os.release()

    if (/Windows/.test(release)) {
        return 'win32'
    }

    if (/Mac/.test(release)) {
        return 'darwin'
    }

    return 'unknown'
}

function isSupportedPlatform(platform) {
    return platforms.includes(platform)
}

module.exports = {
    typeToString,
    isSupportedPlatform,
    platforms,
    getPlatform
}