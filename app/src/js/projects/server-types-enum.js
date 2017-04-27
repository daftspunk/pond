const serverTypes = [
    'pond',
    'vagrant',
    'docker',
    'lamp'
]

function typeToString(type) {
    if (!serverTypes.includes(type)) {
        return 'projects.server_type.unknown'
    }

    return 'projects.server_type.'+type
}

module.exports = {
    typeToString
}