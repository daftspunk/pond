## Current notes

* [ ] Update the main documentation to include steps required for compiling native modules and running the dev process (copy from the DEVNOTES).
* [ ] When working with `keytar` application does not start if it's refreshed with `cmd+r`. Restart it with "Simulate browser restart". - put to readme

* [ ] Find out how to run tests in node.js
* [ ] Implement PHPDeployer features in node.js

* [ ] Rewrite JSON schema, deployer and tests to satisfy the new request structure (the database part).
* [ ] SSL certificates are going to be stored in keychain or similar services. Update readme.

* [ ] New deployments should create a database.
* [ ] New deployments should configure Apache. 

* [ ] The deployment controller should be outputting connection stdout every time it changes.
* [ ] Use special HTTP header for PHP Deployer.
* [ ] Test HTTP code 500 if a command fails.
* [ ] Test no internet connection case

* [ ] Resolve a problem with permissions. Find out what user and group run Apache in the default LAMP configuration on Digital Ocean. Perhaps we can add the Deploy user to the www group.
* [ ] Getting logs - list and contents

**TODO: deployment**

* [ ] Disable logs in slim 
* [ ] The PHP Deployer built-in server should only run during the deployment procedures. Use random TCP ports for that server.

**TODO: provisioning**

* [ ] It should be possible to deploy a project to multiple infrastructures (staging, acceptance test, etc.).
* [ ] It should be possible to run post-provision scripts.

**TODO: PHP 7 support**

**TODO: packaging**

* [ ] Packaging must use webkit production compilation, not browserify
* [ ] The source JavaScript code should be compiled in the version that we give to users. See http://docs.nwjs.io/en/latest/For%20Users/Advanced/Protect%20JavaScript%20Source%20Code/ This should be done during the building process for each platform separately.
* [ ] Some code in the copyBuiltApp() is OSX-specific.
* [ ] Finish packaging with code compilation. Maybe just build .bin as a part of the building process when release runs, and delete main.js if it's a production release.
* [ ] We should use PHAR for the PHP deployer in the production: https://github.com/clue/phar-composer. The archive should not have the .phar extension.

**TODO: creating projects**

* [ ] Client name should be an auto-complete: https://www.npmjs.com/package/autocomplete-vue
* [ ] We should track Pond downloads of the installer with a special Google Analytics event
* [ ] Remember last used Client

**TODO: low-priority**

* [ ] Remove or implement properly the temporary debug code, marked with DEBUG

## Development notes and decisions

Reloading stylesheet:

    $('link').remove(); $('<link rel="stylesheet" href="dist/main.css"></link>').insertAfter('title');

**System requirements**

macOS: 10.10

### Coding standards

**Imports**

Imports should be done with `const`. If the imported object is a class, the constant name should have a capital first letter. Otherwise it should be lower-case.

```
const BaseAgent = require('./base')
const fileSystem = require('../filesystem')
```


### Filesystem operations limitations in node.js in the webkit

It turned out that complex filesystem operations such as recursive directory copying and extracting ZIP archives are nearly impossible in the web context. Popular libraries (fs-extra, unzip) don't work. Because PHP has a much better cross-platform support for filesystem operations, it was decided to use the PHP Pond Agent to perform the following operations:

* Unpacking October archive
* Setting the October configuration

### Pond Agent

Pond Agent is a simple October plugin or a standalone file, which performs operations on behalf of Pond. It accepts POST requests from the local machine. The Agent is installed only when it's needed and removed after it finishes its work.

One of the design goals for the Agent is that it should consist of as few files as possible, because of the complexity of filesystem operations in context of nw.js.

There are two types of the Agent - extractor and configurator. Extractor is a single file which unpacks October package. The configurator type is October plugin, which updates configuration files in the October installation.