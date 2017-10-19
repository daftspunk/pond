## 2017-08-17

The biggest issue by this moment is that not all Node.js code can run in the browser context (NW.js or Electron). In some cases it was possible to replace several third-party classes with our own implementation, but some vital classes, like the SSH client (required for deployment procedures), break when they're compiled with Browserify.

## 2017-08-18

There's a way to overcome the problem with SSH in NW.js application by using a deployment script implemented with PHP. This won't add complexity to the application, as one of the Pond's responsibilities is providing built-in PHP server, so that we already have all components available.

PHP deployer uses Slim framework. I chose Slim, because its twice smaller than Lumen and there are no special requirements for the performance and advanced features.

## 2017-08-21

Created a target-server-dev-enviroment Vagrant environment for emulating working with a cloud target server locally. This environment will also be used to run unit tests in the PHP deployer project.

## 2017-08-22

Updated Scotch box in target-server-dev-enviroment to v.3, because it supports PHP 7. Scaffolding the unit testing environment. BTW, this Vagrant environment contains good examples of integrating custom shell scripts into the Vagrant provisioning process: https://github.com/rlerdorf/php7dev

## 2017-09-05

Instead of replacing the blue or green directories completely, as I was planning from the beginning, we actually should replace only parts of it, e.g. - a specific plugin, core or theme.

## 2017-10-04

Switching the request parameter manual validation to JSON schema validation. This will take time, but should be very beneficial and time saving later. Less tests will be required, less code will have to be written to validate different requests. It will be easy to update validation rules with editing JSON schema strings.

## 2017-10-17

Another challenge. How to protect traffic between Node.js and PHP Deployer components. PHP Deployer is going to be executed with a PHP built-in server, which does not support SSL. So far I see two options:
* Do not allow sensitive information in the request parameters (pass them through files). Cons: there will be files keeping sensitive information.
* Encrypt requests manually with public/private keys known to Node.JS and PHP Deployer. Cons: the keypair is going to be the same for all Pond installations, which makes Pond less secure.

## 2017-10-18

There's a problem with compiling native Node modules with browserify - `keytar`. It's a second case when I can't use a highly necessary module in the application, the first time it was SSH. I know that `keytar` can be used with Electron. Electron uses `webpack` for compiling the code instead of `browserify`. I had lots of issues with configuring `webpack` and never ended up with a satisfying configuration. I'm going to try again. If the attempt fails again I will make a test build of Electron now and see what modules I can load into it.

`ssh2` works with Electron boilerplate project, although there are problems with loading `keytar`, but they seem to resolvable. This doesn't mean yet that we have to switch to Electron yet. The boilerplate uses `webpack`, which is able to compile `ssh2`. The next step is to try to switch the project to `webpack` and see if we can compile `ssh2` in Pond. If it works and `keytar` works we will need to abandon the PHP deployer project and implement this part in `node.js` which is not that bad, because the distinctive functionality of PHP Deployer is not too complicated and I have spent a lot of time implementing the request validation and experimenting. The functionality can be easily copied to node.js. There are big benefit in having the deployment part implemented in node.js:

 - We don't need to worry about starting the built-in server for running the deployer, which adds the reliability
 - No need to worry about protecting the channel between node.js and deployer.
 - Delivering messages from the deployer to UI in real time becomes a trivial task.