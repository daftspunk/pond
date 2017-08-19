# October CMS Pond

The outer directory is the NW.js building framework. The `app` directory is the actual application and its building framework.

## Environment building and running

**Note:** all commands should be ran in the root directory, which contains the `app` subdirectory.

### Setting up required libraries

First, **download and install NodeJS and NPM**. Then:

* `sudo npm install -g browserify`
* `sudo npm install -g watchify`

### Install packages:

In the root Pond directory run:

* `npm install`

This will take a long time. Ignore NPM warning `Invalid name: "October CMS Pond"` and do not change the value.

Here is a weird part. Although `"nw": "^0.23.6-sdk-1"` is specified in package.json, running `npm run dev` throws an error on my Mac. Running these commands help:

* `npm uninstall --sav-dev nw`
* `npm install --save-dev nw@0.23.6-sdk-1`

### Install PHP binaries

#### macOS

* Download a build for the PHP version specified in src/js/config/index.js `builtInServerInfo.darwin.php.version` here: https://php-osx.liip.ch/
* Run the installer
* Copy the directory from /usr/local/php.xxx to `app/src/assets-bin-php/darwin` (so that `darwin` contains `bin`, `etc`, `lib` and so on).
* Run `npm run copy-bin-assets` in the Pond's root directory.

#### Windows

* TODO. Perhaps standard PHP binaries will work fine. They should be copied to `app/src/assets-bin-php/win32`.

**Important:** We need to have SSH2 PHP library available in the built-in server. For Windows it requires a DLL for specific version of PHP. Hopefully, we can just download a file without building anything. See https://pecl.php.net/package/ssh2/1.1.2/windows, https://www.libssh2.org/.

### Windows only - install NSIS installer

As installer [NSIS](http://nsis.sourceforge.net/Main_Page) is used for building Windows releases. You have to install it (version 3.0), and add NSIS folder to PATH in Environment Variables, so it is reachable to scripts in this project (path should look something like C:/Program Files (x86)/NSIS).

It's OK to upgrade the supported PHP version as long as it is compatible with the minimum target system requirements (see below). It's important to keep the version string actual in src/js/config/index.js.

### Install composer dependencies

Run `composer install` in app/src/php-deployer.

### Start the development building process

* `npm run watch`

This will be updating assets in app/dist in live mode. It could take ~15 seconds to load first, but subsequent updates take milliseconds.

After that, in another terminal tab, start NW.js:

* `npm run dev`

The application still should be refreshed manually in NW.js window when needed. This can be done in NW.js console using the command: `nw.Window.get().reload()`. To open the console use normal Chrome development tools hot keys.

### Compiling LESS

LESS is compiled automatically when `watch` command runs. If there was a compilation error (file not found, missing semicolon, etc.) it might be needed to save `theme.less` or any `.vue` file to reanimate the compiler.

### Copying lightweight assets

Lightweight assets (images, Pond Agent files) are currently copied only once, when `watch` command starts. Restart `watch` after changing assets. This will be automated later. 

Also, assets can be copied manually by running `npm run copy-assets`.

### Copying heavy binary assets

Binary assets are PHP files for the built-in Pond server. Copying them takes much time, so they are not copied when `watch` starts. Use `npm run copy-bin-assets` to copy updated binary assets.

## Packaging

The packaging process creates distributive installers. macOS installer should be built in macOS, and Windows installer - in Windows. The outer directory hosts the SDK flavor of NW.js, which can't be used for packaging. That's why there's the `nw-normal` directory, which contains a normal NW.js flavor. 

* Execute `npm run release`. This will create an installer file specific to the platform in the `releases` directory.

Packaging copies `index.html`, `package.json` files and `dist` directory from the `app` directory to the final archive. If other files must be copied, update `tasks/util.js`. Before the packaging starts, the script builds the JavaScript and CSS and copies lightweight and platform-specific binary assets to `dist`.

By default packaging uses the normal (non SDK) flavor of NW.js. For debugging needs it's possible to build a package with SDK flavor with `POND_DEV_RELEASE=true npm run release`.

## Coding standards

Coding standards are usual (no semicolons) with some additions.

### Imports for scripts

Imports should be done with `const`. If the imported object is a class (can be used with `new`), the constant name should have a capital first letter. Otherwise it should be lower-case. **TODO:** update the code to use this rule everywhere.


```
const BaseAgent = require('./base')
const fileSystem = require('../filesystem')

const agent = new BaseAgent()
fileSystem.copy()
```

### Imports for Vue components

Components considered to be classes, so the first letter is capital:

```
import Welcome from './welcome.vue'
```

## Application design notes

Pond is created to be as simple as possible. In order to achieve this some features must be hidden or limited, even although they could be wanted by advanced users. It's not impossible to fine-tune October installation by editing configuration files, so those users have options. In particular:

* File and folder permission modes are not presented in the installer Advanced Options, because Pond is a local installation manager. Files and folders are created with 777 mode, making its possible for user to edit and remove files if needed.
* The back-end URL is always /backend.

## UX notes

* Do not use animation without purpose (for decoration).
* Use Icomoon icon set.
* Always avoid half-pixels in icons.

## Target system requirements

* macOS: 10.10

## TODO

* NW.js production building script for Windows
* Automate asset copying in `watch`
* Find a suitable license. No liability, can't be modified or published by others.
* It's possible to implement automatic reloading on change with gulp. Do that if manual reloading gets annoying.