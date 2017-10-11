<?php namespace PhpDeployer\Operations;

use PhpDeployer\Exceptions\Http as HttpException;
use Respect\Validation\Validator as Validator;
use PhpDeployer\Operations\Misc\DeploymentEnvironment;
use Exception;

/**
 * Returns the status.json file contents
 */
class Status extends Base
{
    public function setConfigurationParameters($parameters)
    {
        throw new Exception('Remove - should not be used');

        $this->setProjectDirectoryName($this->getParameterValue($parameters, 'projectDirectoryName'));
        $this->setEnvironmentDirectoryName($this->getParameterValue($parameters, 'environmentDirectoryName'));
    }

    protected function validateRequest()
    {
        $this->requestContainer->validate('STATUS_REQUIRED_ARGUMENTS');
    }

    public function run()
    {
        $connection = $this->getConnection();

        $environmentDirectory = $this->getEnvironmentDirectoryRemotePath();
        if (!$connection->directoryExists($environmentDirectory)) {
            throw new HttpException(sprintf('The environment directory is not found on the server: %s', $environmentDirectory), 400);
        }

        $connection = $this->getConnection();
        $remoteFilePath = $environmentDirectory.'/metadata/status.json';
        if (!$connection->fileExists($remoteFilePath)) {
            throw new HttpException(sprintf('The environment status file is not found on the server: %s', $remoteFilePath), 400);
        }

        $jsonContents = $connection->runCommand('cat {{$path}}', 10, ['path'=>$remoteFilePath]);

        if (!strlen($jsonContents)) {
            throw new Exception('The status file is empty');
        }

        $statusObject = @json_decode($jsonContents, true);
        if ($statusObject === null) {
            throw new Exception('Error parsing the status file');
        }

        $deploymentEnvironment = new DeploymentEnvironment(
            $this->getConnection(),
            $this->getEnvironmentDirectoryRemotePath());

        $activeEnvironment = $deploymentEnvironment->getActive();

        $result = [
            'status' => $statusObject,
            'active' => $activeEnvironment
        ];

        return $result;
    }

    public function saveRemoteStatus($success)
    {
        // This operation doesn't change the server state
    }
}