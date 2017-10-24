const types = [
    'pond',
    'vagrant',
    'docker',
    'lamp'
]

function typeToString(type) {
    if (!types.includes(type)) {
        return 'projects.environment_type.unknown'
    }

    return 'projects.environment_type.'+type
}

function isKnownEnvironment(environment) {
    return types.includes(environment)
}

export default {
    typeToString,
    types,
    isKnownEnvironment
}