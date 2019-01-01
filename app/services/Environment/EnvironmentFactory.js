import Environment from './Environment'
import EnvironmentTypes from './EnvironmentTypes'
import platforms from '../../utils/platforms'

import ServerManagerPondWin32 from '../Servers/PondServer.Win32'
import ServerManagerPondDarwin from '../Servers/PondServer.Darwin'

export function createEnvironment(website) {
    const platform = platforms.getPlatform();

    if (!EnvironmentTypes.isKnownEnvironment(website.environmentType)) {
        throw new Error('Unknown environment type');
    }

    if (!platforms.isSupportedPlatform(platform)) {
        throw new Error('Unsupported platform: ' + platform);
    }

    const serverManagerClass = getServerManagerClass(website, platform);

    return new Environment(
        website,
        new serverManagerClass(website)
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
