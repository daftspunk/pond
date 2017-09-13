<?php namespace PhpDeployer\Controllers;

use PhpDeployer\Operations\Deployment as DeploymentOperation;
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
        $deployment->run();
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
        $configuration->run();
    }

    private function validateDeployParamsArgument()
    {
        $this->validateArgumentsExist(['params']);

        if (!Validator::arrayType()->validate($this->getRequestArgument('params'))) {
            throw new HttpException('The params argument should be an array', 400);
        }
    }
}