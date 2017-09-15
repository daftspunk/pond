<?php namespace PhpDeployer\Controllers;

use PhpDeployer\Operations\Deployment as DeploymentOperation;
use PhpDeployer\Operations\Configuration as ConfigurationOperation;
use PhpDeployer\Exceptions\Http as HttpException;
use Respect\Validation\Validator as Validator;

class Deployment extends Base
{
    public function deployProject()
    {
        $this->validateDeployParamsArgument();

        $deployment = new DeploymentOperation();
        $deployment->setConnectionParameters(
            $this->getRequestArgument('privateKeyPath'),
            $this->getRequestArgument('publicKeyPath'),
            $this->getRequestArgument('ip'),
            $this->getRequestArgument('user'));

        $deployment->setDeploymentParameters($this->getRequestArgument('params'));

        // We call saveRemoteLog() in the controller
        // and not inside the run() method, because
        // commands can invoke each other's run() method 
        // and we want the log to be saved only once.

        try {
            $deployment->run();
        }
        finally {
            $deployment->saveRemoteLog();
        }
    }

    public function configureProject()
    {
        $this->validateDeployParamsArgument();

        $configuration = new ConfigurationOperation();
        $configuration->setConnectionParameters(
            $this->getRequestArgument('privateKeyPath'),
            $this->getRequestArgument('publicKeyPath'),
            $this->getRequestArgument('ip'),
            $this->getRequestArgument('user'));

        $configuration->setConfigurationParameters($this->getRequestArgument('params'));

        try {
            $configuration->run();
        }
        finally {
            $configuration->saveRemoteLog();
        }
    }

    private function validateDeployParamsArgument()
    {
        $this->validateArgumentsExist(['params']);

        if (!Validator::arrayType()->validate($this->getRequestArgument('params'))) {
            throw new HttpException('The params argument should be an array', 400);
        }
    }
}