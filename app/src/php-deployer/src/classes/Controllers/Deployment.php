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
        $deployment = new DeploymentOperation($this->getRequestContainer());

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
        $configuration = new ConfigurationOperation($this->getRequestContainer());

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
        $swap = new SwapOperation($this->getRequestContainer());

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
        $status = new StatusOperation($this->getRequestContainer());
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