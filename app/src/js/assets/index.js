import path from 'path'
import config from '../config'

function getDistDir() {
    if (config.getPondEnvironmentName() == 'production') {
        const processDir = process.cwd()

        // TODO: it's likely Windows environment another
        // path to the assets directory directory.

        return path.dirname(processDir) + '/app.nw/dist'
    }
    else {
        return process.cwd() + '/dist'
    }
}

function getAssetsDir() {
    return getDistDir() + '/assets'
}

function getPhpBinDir() {
    return getDistDir() + '/assets-bin-php'
}

export default {
    getAssetsDir,
    getPhpBinDir
}
