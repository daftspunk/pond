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
