# October CMS Pond

The outer directory is the NW.js building framework. The `app` directory is the actual application and its building framework.

## Environment building and running

### Building environment requirements

First, download and install NodeJS and NPM. Then:

* `sudo npm install -g browserify`
* `sudo npm install -g watchify`
* `sudo npm i -g nwjs` - see https://www.npmjs.com/package/nwjs. This is needed for installing the NW.js SDK flavor.
* `nw install 0.21.6-sdk`

### Install packages:

* npm install

### Start the development building process

* `npm run watch`

This will be updating assets in app/dist in live mode. It could take ~15 seconds to load first, but subsequent updates take milliseconds.

After that, in another terminal tab, start NW.js:

* `npm run dev`

The application still should be refreshed manually in NW.js window when needed. This can be done in NW.js console using the command: `nw.Window.get().reload()`. To open the console use normal Chrome development tools hot keys.

### Compiling LESS

LESS is compiled automatically when `watch` command runs. If there was a compilation error (file not found, missing semicolon, etc.) it might be needed to save `theme.less` or any `.vue` file to reanimate the compiler.

### Copying assets

Assets (images) are currently copied only once, when `watch` command starts. Restart `watch` after changing assets. This will be automated later. 

Also, assets can be copied manually by running `npm run copy-assets`.

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

## TODO

* NW.js production building script for Mac and Windows
* The NW.js production building process should copy index.htm to the temporary directory
* The NW.js production building should generate minified versions of main.js and main.css
* The NW.js production build should use production flavor of nw, not the SDK one
* The NW.js production build copy assets to dist
* Automate asset copying in `watch`
* Find a suitable license. No liability, can't be modified or published by others.
* It's possible to implement automatic reloading on change with gulp. Do that if manual reloading gets annoying.

