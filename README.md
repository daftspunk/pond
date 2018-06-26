# pond

Desktop application for development and deployment Pond consists of the following runtime components:

- `assets` - images, JavaScript files, CSS files
- `binary assets` - this includes PHP binaries for Mac and Windows
- `Electron` runs the desktop client, top level of the execution
- `Chromium browser` - is run by Electron and represents the interactive layer of the application
- `Node.js` is a top-level runtime environment, it's ran by Chromium
- `Vue.js and Vuex.js` render the HTML and manage the application runtime data state
- `Built-in PHP server` runs Pond projects, which chose to use the built-in server, and also runs PHP Deployer when the application is in the runtime mode (for the development needs we use `Target server dev environment` for running the Deployer)
- `Pouch DB` used as a persistent data storage
- `Pond Agent` is a special October plugin that Pond installs to configure a local project.

## Environment building and running

**Note:** all commands should be ran in the root directory, which contains the `app` subdirectory.

Prerequisites: node.js of version at lest 8.x is required for running unit tests. I used the version 6.x successfully for the development, but had to upgrade to run mocha tests.

### Install packages:

In the root Pond directory run:

* `npm install`

### Start the development building process

* `npm run watch`

This will be updating assets in app/dist in live mode. It could take ~15 seconds to load first, but subsequent updates take milliseconds.

After that, in another terminal tab, start Electron:

* `npm run start`

### Install PHP binaries

Find the PHP version specified in the file src/js/config/index.js in object path `builtInServerInfo.darwin.php.version`, for example `7.1`.

#### macOS

* Download a PHP build matching the version here: https://php-osx.liip.ch/
* Run the installer
* Copy the directory from /usr/local/php.xxx to `app/src/assets-bin-php/darwin` (so that `darwin` contains `bin`, `etc`, `lib` and so on).
* Run `npm run copy-bin-assets` in the Pond's root directory.

> Note: Following liip.ch's install will [restart the Apache web server](https://github.com/liip/php-osx/blob/e811dd814a166c469063fd78d2eaa8ff1d41c63b/create_package.sh#L84-L101) that ships with macOS. For those using MAMP, XAMPP, Docker or another web server on port 80, this may be confusing. Run `sudo /usr/sbin/apachectl stop` to stop Apache.

#### Windows

* Download a PHP build matching the version here: https://windows.php.net/
* Run the installer
* Copy the directory from /usr/local/php.xxx to `app/src/assets-bin-php/win32` (so that `darwin` contains `bin`, `etc`, `lib` and so on).
* Run `npm run copy-bin-assets` in the Pond's root directory.
