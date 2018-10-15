import Initializer from './Initializer';
import EnvironmentTypes from '../Environment/EnvironmentTypes';
import platforms from '../../utils/platforms';
import Scanner from './Scanner';

import ServerManagerPondDarwin from '../Servers/PondServer.Darwin';
import ServerManagerPondWin32 from '../Servers/PondServer.Win32';

import ProvisionerPondDarwin from '../Provisioners/PondProvisioner.Darwin';
import ProvisionerPondWin32 from '../Provisioners/PondProvisioner.Win32';

export function createScanner(project) {
    return new Scanner(project);
}

export function createInitializer(website) {
    const platform = platforms.getPlatform();

    if (!EnvironmentTypes.isKnownEnvironment(website.environmentType)) {
        throw new Error('Unknown environment type');
    }

    if (!platforms.isSupportedPlatform(platform)) {
        throw new Error('Unsupported platform: ' + platform);
    }

    const serverManagerClass = getServerManagerClass(website, platform);
    const provisionerClass = getProvisionerClass(website, platform);

    return new Initializer(
        website,
        new serverManagerClass(website),
        new provisionerClass(website)
    );
}

//
// Internals
//

function getServerManagerClass(website, platform) {
    if (website.environmentType == 'pond' && platform == 'darwin') {
        return ServerManagerPondDarwin;
    }

    if (website.environmentType == 'pond' && platform == 'win32') {
        return ServerManagerPondWin32;
    }

    const errorString = `Server manager for ${website.environmentType}/${platform} is not currently supported`;
    throw new Error(errorString);
}

function getProvisionerClass(website, platform) {
    if (website.environmentType == 'pond' && platform == 'darwin') {
        return ProvisionerPondDarwin;
    }

    if (website.environmentType == 'pond' && platform == 'win32') {
        return ProvisionerPondWin32;
    }

    const errorString = `Environment provisioner for ${website.environmentType}/${platform} is not currently supported`;
    throw new Error(errorString);
}
