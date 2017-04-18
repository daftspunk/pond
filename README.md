# October CMS Pond

The outer directory is the NW.js building framework. The `app` directory is the actual application and its building framework.

## Building environment requirements

First, download and install NodeJS and NPM. Then:

* `sudo npm install -g browserify`
* `sudo npm install -g watchify`
* `sudo npm i -g nwjs` - see https://www.npmjs.com/package/nwjs. This is needed for installing the NW.js SDK flavor.
* `nw install 0.21.6-sdk`

## Install packages:

* npm install

## Start the development building process

* `cd app`
* `watchify -t vueify -p [ vueify/plugins/extract-css -o dist/main.css ] -e src/js/main.js -o dist/main.js -v`

This will be updating assets in /dist in live mode. `watchify` takes ~15 seconds to load first, but subsequent updates take milliseconds.

After that, in another terminal tab, start NW.js:

* `npm run dev` (in the outer directory, not in `app`)

The application still should be refreshed manually in NW.js window when needed. This can be done in NW.js console using the command: `nw.Window.get().reload()`. To open the console use normal Chrome development tools hot keys.

## TODO

* NW.js production building script for Mac and Windows
* The NW.js production building process should copy index.htm to the temporary directory
* The NW.js production building should generate minified versions of main.js and main.css
* The NW.js production build should use production flavor of nw, not the SDK one
* Find a suitable license. No liability, can't be modified or published by others.
* It's possible to implement automatic reloading on change with gulp. Do that if manual reloading gets annoying.