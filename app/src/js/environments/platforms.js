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
    return nw.require("os").platform()
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