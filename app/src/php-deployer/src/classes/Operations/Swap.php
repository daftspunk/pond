<?php namespace PhpDeployer\Operations;

use PhpDeployer\Exceptions\Http as HttpException;
use PhpDeployer\Operations\Misc\RemoteStatusManager;
use PhpDeployer\Operations\Misc\DeploymentEnvironment;
use Respect\Validation\Validator as Validator;
use Exception;

/**
 * Swaps an active deployment environment
 */
class Swap extends Base
{
    // The following properties must stay private.
    // If they're set from external sources, their
    // values must be validated.

   private $activate;

    // public function setConfigurationParameters($parameters)
    // {
    //     throw new Exception('Remove - should not be used');

    //     parent::loadPermissionData($parameters);

    //     $this->setProjectDirectoryName($this->getParameterValue($parameters, 'projectDirectoryName'));
    //     $this->setEnvironmentDirectoryName($this->getParameterValue($parameters, 'environmentDirectoryName'));
    //     $this->activate = $this->getParameterValue($parameters, 'activate');

    //     if (!Validator::stringType()->validate($this->activate)) {
    //         throw new HttpException('The activate parameter must be a string.', 400);
    //     }

    //     if (!in_array($this->activate, DeploymentEnvironment::DPE_BOTH)) {
    //         throw new HttpException('The activate parameter value must "blue" or "green".', 400);
    //     }
    // }

    protected function validateRequest()
    {
        $this->requestContainer->validate('SWAP_REQUIRED_ARGUMENTS');

        $this->activate = $this->get('params.activate');
    }

    public function run()
    {
        $connection = $this->getConnection();

        $environmentDirectory = $this->getEnvironmentDirectoryRemotePath();
        if (!$connection->directoryExists($environmentDirectory)) {
            throw new HttpException(sprintf('The environment directory is not found on the server: %s', $environmentDirectory), 400);
        }

        $deploymentEnvironment = new DeploymentEnvironment(
            $this->getConnection(),
            $this->getEnvironmentDirectoryRemotePath());

        $inactiveEnvironment = $deploymentEnvironment->getInactive();
        if ($inactiveEnvironment != $this->activate) {
            throw new HttpException(sprintf('The %s environment is already active.', $this->activate), 400);
        }

        $deploymentEnvironment->makeActive($this->activate);
    }

    public function saveRemoteStatus($success)
    {
        $logRecordDetails = RemoteStatusManager::makeLogRecordArray(
            $success, 
            [], 
            [$this->activate],
            RemoteStatusManager::TYPE_SWAP
        );

        $this->updateRemoteStatus($logRecordDetails, null);
    }
}