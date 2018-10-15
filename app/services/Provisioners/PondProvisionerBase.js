import validator from 'validator';
import ProvisionerBase from './ProvisionerBase';
import fileSystem from '../../utils/filesystem';
import portFinder from '../../utils/portFinder';
import validationUtils from '../../utils/validation';
import { ONLINE } from '../../constants/EnvironmentConstants';
import { getAssetsDir } from '../../utils/assets';

/**
 * Environment provisioner:
 *
 *  - Pond built-in environment
 */

const scriptName = 'server.php';

export default class Provisioner extends ProvisionerBase {

    async validateConfiguration(errorBag, websites) {
        if (validator.isEmpty(validationUtils.toSafeString(this.website.localPort))) {
            errorBag.add('localPort', 'websites.create_website.error_local_port_empty');
            return;
        }

        if (!validator.isInt(validationUtils.toSafeString(this.website.localPort))) {
            errorBag.add('localPort', 'websites.create_website.error_local_port_not_integer');
            return;
        }

        const otherWebsite = portFinder.isInUseByAWebsite(this.website.localPort, websites)
        if (otherWebsite && otherWebsite.id != this.website.id) {
            errorBag.add('localPort', 'websites.create_website.error_local_port_used_by_another_website');
            return;
        }

        try {
            await portFinder.isInUseByAnotherApp(this.website.localPort, '127.0.0.1');
        }
        catch (e) {
            if (this.website.runtime && this.website.runtime.status != ONLINE) {
                // If the port is in use by this very website and it's online,
                // return no errors.

                return;
            }

            errorBag.add('localPort', 'websites.create_website.error_local_port_used_by_another_app');
            return;
        }
    }

    async run(installerTmpPath, textLog) {
        await super.run(installerTmpPath, textLog);

        // In Pond environment we don't need to provision anything.
        // Just put the archive and server.php to the website's
        // directory.

        const asssetsDir = getAssetsDir();

        fileSystem.copy(asssetsDir + '/pond/' + scriptName, this.website.location + '/' + scriptName);
    }

    async errorCleanup() {
        return fileSystem.unlink(this.website.location + '/' + scriptName);
    }
}
