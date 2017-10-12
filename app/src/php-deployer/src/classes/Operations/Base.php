<?php namespace PhpDeployer\Operations;

use PhpDeployer\Ssh\Connection;
use PhpDeployer\Exceptions\Http as HttpException;
use PhpDeployer\Util\Configuration as DeployerConfiguration;
use PhpDeployer\Operations\Misc\RemoteStatusManager;
use PhpDeployer\Operations\Misc\RequestPermissionData;
use Respect\Validation\Validator as Validator;
use PhpDeployer\Util\RequestContainer;
use Exception;

/**
 * Base class for deployment and configuration operations.
 */
abstract class Base
{
    private $connection;
    private $scpConnection;

    protected $requestContainer;

    private $logCallable;
    private $combinedLog = [];

    public function __construct(RequestContainer $requestContainer, Connection $connection = null, Connection $scpConnection = null)
    {
        $this->requestContainer = $requestContainer;

        // This allows to reuse an existing connection when
        // the operation is used from inside of another 
        // operation.
        $this->connection = $connection;
        $this->scpConnection = $scpConnection;

        $this->validateRequest();
    }

    abstract protected function validateRequest();
    abstract public function run();
    abstract public function saveRemoteStatus($success);

    public function setLogCallable(callable $logCallable)
    {
        $this->logCallable = $logCallable;
    }

    public function saveRemoteLog()
    {
        try {
            $this->uploadRemoteLog();
        }
        catch (Exception $ex) {
            // This will push the message to the client
            $this->handleConnectionLogEntry(sprintf('Error creating log file on the server. %s', $ex->getMessage()));
        }
    }

    protected function get($param, $optional = false, $default = null)
    {
        return $this->requestContainer->get($param, $optional, $default);
    }

    protected function getConnection()
    {
        if (!$this->connection) {
            $this->connection = new Connection(
                $this->get('ip'), 
                $this->get('publicKeyPath'),
                $this->get('privateKeyPath'),
                $this->get('user')
            );

            $this->connection->setLogCallable(function($string) {
                $this->handleConnectionLogEntry($string);
            });
        }

        return $this->connection;
    }

    protected function getScpConnection()
    {
        if (!$this->scpConnection) {
            $this->scpConnection = new Connection(
                $this->get('ip'), 
                $this->get('publicKeyPath'),
                $this->get('privateKeyPath'),
                $this->get('user')
            );

            $this->scpConnection->setLogCallable(function($string) {
                $this->handleConnectionLogEntry($string);
            });
        }

        return $this->scpConnection;
    }

    protected function getProjectDirectoryName()
    {
        return $this->get('params.projectDirectoryName');
    }

    protected function getEnvironmentDirectoryName()
    {
        return $this->get('params.environmentDirectoryName');
    }

    protected function getProjectDirectoryRemotePath()
    {
        return DeployerConfiguration::POND_ROOT.'/'.$this->getProjectDirectoryName();
    }

    protected function getEnvironmentDirectoryRemotePath()
    {
        return $this->getProjectDirectoryRemotePath().'/'.$this->getEnvironmentDirectoryName();
    }

    protected function makeRemoteTempFileName()
    {
        $result = microtime(true);

        return str_replace('.', '-', $result);
    }

    protected function updateRemoteStatus($logRecordDetails, $deploymentEnvironmentsDetails)
    {
        try {
            $statusManager = new RemoteStatusManager($this->getConnection(), $this->getScpConnection(), $this->requestContainer);
            $statusManager->updateStatus(
                $this->getEnvironmentDirectoryRemotePath(),
                $logRecordDetails,
                $deploymentEnvironmentsDetails
            );
        }
        catch (Exception $ex) {
            // This will push the message to the client
            $this->handleConnectionLogEntry(sprintf('Error updating environment status file on the server. %s', $ex->getMessage()));
        }
    }

    private function handleConnectionLogEntry($string)
    {
        $this->combinedLog[] = $string;

        $callable = $this->logCallable;
        if ($callable) {
            $callable($string);
        }
    }

    private function uploadRemoteLog()
    {
        $commandConnection = $this->getConnection();

        $envDirectory = $this->getEnvironmentDirectoryRemotePath();
        $remoteTmpDir = $envDirectory.'/pond-tmp';
        $contents = implode("\n", $this->combinedLog);

        $serverTime = $commandConnection->runCommand('date +"%Y-%m-%dT%T"');
        $finalLogPath = $envDirectory.'/metadata/log/'.$serverTime.'.txt';

        $this->getScpConnection()->uploadFromString(
            $commandConnection, 
            $contents, 
            $finalLogPath, 
            $remoteTmpDir, 
            $this->get('params.permissions.file'),
            'log file'
        );
    }
}