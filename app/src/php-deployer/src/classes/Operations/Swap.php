<?php namespace PhpDeployer\Operations;

use PhpDeployer\Exceptions\Http as HttpException;
use PhpDeployer\ConfigurationTemplate\View as ConfigurationTemplateView;
use PhpDeployer\Operations\Misc\RemoteStatusManager;
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

    public function setConfigurationParameters($parameters)
    {
        parent::loadPermissionData($parameters);

        $this->setProjectDirectoryName($this->getParameterValue($parameters, 'projectDirectoryName'));
        $this->setEnvironmentDirectoryName($this->getParameterValue($parameters, 'environmentDirectoryName'));
        $this->activate = $this->getParameterValue($parameters, 'activate');

        if (!Validator::stringType()->validate($this->activate)) {
            throw new HttpException('The activate parameter must be a string.', 400);
        }

        if (!in_array($this->activate, ['blue', 'green'])) {
            throw new HttpException('The activate parameter value must "blue" or "green".', 400);
        }
    }

    public function run()
    {
        $connection = $this->getConnection();

        // Get the active deployment environment (factor out code from the deployment operation).
        // Check if the activate parameter is correct.
        // Change the active environment
        // Save remote status
    }

    public function saveRemoteStatus($success)
    {
        //TODO

        // $logRecordDetails = RemoteStatusManager::makeLogRecordArray(
        //     $success, 
        //     ['config'], 
        //     ['blue', 'green']);

        // $this->updateRemoteStatus($logRecordDetails, null);
    }
}