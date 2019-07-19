export function getDistDir() {
    const remote = window.require('electron').remote;
    return remote.process.cwd() + '/dist';
}

export function getAssetsDir() {
    return getDistDir() + '/assets';
}

export function getPhpBinDir() {
    return getDistDir() + '/assets-bin-php';
}
