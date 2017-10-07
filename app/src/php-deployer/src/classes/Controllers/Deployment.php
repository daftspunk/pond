<?php namespace PhpDeployer\Controllers;

use PhpDeployer\Operations\Deployment as DeploymentOperation;
use PhpDeployer\Operations\Configuration as ConfigurationOperation;
use PhpDeployer\Operations\Status as StatusOperation;
use PhpDeployer\Operations\Swap as SwapOperation;
use PhpDeployer\Exceptions\Http as HttpException;
use Respect\Validation\Validator as Validator;
use Exception;

class Deployment extends Base
{
    public function deployProject()
    {
        $this->validateDeployParamsArgument();

        $deployment = new DeploymentOperation($this->getRequestContainer());

        // $deployment->setConnectionParameters(
        //     $this->getRequestArgument('privateKeyPath'),
        //     $this->getRequestArgument('publicKeyPath'),
        //     $this->getRequestArgument('ip'),
        //     $this->getRequestArgument('user'));

        // $deployment->setDeploymentParameters($this->getRequestArgument('params'));

        // We call saveRemoteLog() and saveRemoteStatus() in the controller
        // and not inside the run() method, because
        // commands can invoke each other's run() method 
        // and we want the log to be saved only once.

        try {
            $deployment->run();
            $deployment->saveRemoteStatus(true);
        }
        catch (Exception $ex) {
            $deployment->saveRemoteStatus(false);
            throw $ex;
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
            $configuration->saveRemoteStatus(true);
        }
        catch (Exception $ex) {
            $configuration->saveRemoteStatus(false);
            throw $ex;
        }
        finally {
            $configuration->saveRemoteLog();
        }
    }

    public function swapEnvironments()
    {
        $this->validateDeployParamsArgument();

        $swap = new SwapOperation();
        $swap->setConnectionParameters(
            $this->getRequestArgument('privateKeyPath'),
            $this->getRequestArgument('publicKeyPath'),
            $this->getRequestArgument('ip'),
            $this->getRequestArgument('user'));

        $swap->setConfigurationParameters($this->getRequestArgument('params'));

        try {
            $swap->run();
            $swap->saveRemoteStatus(true);
        }
        catch (Exception $ex) {
            $swap->saveRemoteStatus(false);
            throw $ex;
        }
        finally {
            $swap->saveRemoteLog();
        }
    }

    public function getStatus()
    {
        $this->validateDeployParamsArgument();

        $status = new StatusOperation();
        $status->setConnectionParameters(
            $this->getRequestArgument('privateKeyPath'),
            $this->getRequestArgument('publicKeyPath'),
            $this->getRequestArgument('ip'),
            $this->getRequestArgument('user'));

        $status->setConfigurationParameters($this->getRequestArgument('params'));

        $data = $status->run();

        return $this->response->withJson($data, 200);
    }

    private function validateDeployParamsArgument()
    {
        $this->validateArgumentsExist(['params']);

        if (!Validator::arrayType()->validate($this->getRequestArgument('params'))) {
            throw new HttpException('The params argument should be an array', 400);
        }
    }
}