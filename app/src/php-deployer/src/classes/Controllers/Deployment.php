<?php namespace PhpDeployer\Controllers;

use PhpDeployer\Operations\Deployment as DeploymentOperation;
use Respect\Validation\Validator as Validator;

class Deployment extends Base
{
    public function deployProject()
    {
        $this->validateDeployProjectArguments();

        $deployment = new DeploymentOperation();
        $deployment->setConnectionParameters(
            $this->getRequestArgument('privateKeyPath'),
            $this->getRequestArgument('publicKeyPath'),
            $this->getRequestArgument('ip'),
            $this->getRequestArgument('user'));

        $deployment->setDeploymentParameters(
            $this->getRequestArgument('update'),
            $this->getRequestArgument('projectDirectoryName'),
            $this->getRequestArgument('environmentDirectoryName'));

        $deployment->run();
    }

    private function validateDeployProjectArguments()
    {
        $this->validateArgumentsExist([
            'update',
            'projectDirectoryName',
            'environmentDirectoryName'
        ]);
    }
}