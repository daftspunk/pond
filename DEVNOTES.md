## 2017-08-17

The biggest issue by this moment is that not all Node.js code can run in the browser context (NW.js or Electron). In some cases it was possible to replace several third-party classes with our own implementation, but some vital classes, like the SSH client (required for deployment procedures), break when they're compiled with Browserify.

## 2017-08-18

There's a way to overcome the problem with SSH in NW.js application by using a deployment script implemented with PHP. This won't add complexity to the application, as one of the Pond's responsibilities is providing built-in PHP server, so that we already have all components available.

PHP deployer uses Slim framework. I chose Slim, because its twice smaller than Lumen and there are no special requirements for the performance and advanced features.

## 2017-08-21

Created a target-server-dev-enviroment Vagrant environment for emulating working with a cloud target server locally. This environment will also be used to run unit tests in the PHP deployer project.

## 2017-08-22

Updated Scotch box in target-server-dev-enviroment to v.3, because it supports PHP 7. Scaffolding the unit testing environment. BTW, this Vagrant environment contains good examples of integrating custom shell scripts into the Vagrant provisioning process: https://github.com/rlerdorf/php7dev