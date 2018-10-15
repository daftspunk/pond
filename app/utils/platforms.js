const platforms = [
    'darwin',
    'win32'
];

function typeToString(type) {
    if (!types.includes(type)) {
        return 'projects.platform_type.unknown';
    }

    return 'projects.platform_type.'+type;
}

function getPlatform() {
    const remote = window.require('electron').remote;
    return remote.require('os').platform();
}

function isSupportedPlatform(platform) {
    return platforms.includes(platform);
}

export default {
    typeToString,
    isSupportedPlatform,
    platforms,
    getPlatform
}
