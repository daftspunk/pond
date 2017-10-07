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

    // protected $privateKeyPath;
    // protected $publicKeyPath;
    // protected $ip;
    // protected $user;

    private $logCallable;
    private $combinedLog = [];

    // The following properties must stay private.
    // If they're set from external sources, their
    // values must be validated.

    // private $projectDirectoryName;
    // private $environmentDirectoryName;
    // private $permissionData;

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

    /**
     * Sets the common connection parameters.
     *
     * All the parameters should be validated by the calling code.
     * For HTTP requests it's done in ControllerBase.
     */
    // public function setConnectionParameters($privateKeyPath, $publicKeyPath, $ip, $user)
    // {
    //     $this->privateKeyPath = $privateKeyPath;
    //     $this->publicKeyPath = $publicKeyPath;
    //     $this->ip = $ip;
    //     $this->user = $user;
    // }

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

    protected function get($param)
    {
        return $this->requestContainer->get($param);
    }

    protected function getConnection()
    {
        if (!$this->connection) {
            $this->connection = new Connection(
                $this->ip, 
                $this->publicKeyPath,
                $this->privateKeyPath,
                $this->user);

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
                $this->ip, 
                $this->publicKeyPath,
                $this->privateKeyPath,
                $this->user);

            $this->scpConnection->setLogCallable(function($string) {
                $this->handleConnectionLogEntry($string);
            });
        }

        return $this->scpConnection;
    }

    // protected function getParameterValue($params, $key, $required = true, $default = null)
    // {
    //     if (!array_key_exists($key, $params)) {
    //         if ($required) {
    //             throw new HttpException(sprintf('Required parameter %s not found in the request', $key), 400);
    //         }

    //         return $default;
    //     }

    //     return $params[$key];
    // }

    // protected function setProjectDirectoryName($value)
    // {
    //     if (!Validator::notEmpty()->alnum('-_')->noWhitespace()->validate($value)) {
    //         throw new HttpException('The project directory name can contain only alphanumeric, dash and underscore characters', 400);
    //     }

    //     $this->projectDirectoryName = $value;
    // }

    protected function getProjectDirectoryName()
    {
        throw Exception('Rewrite');
        return $this->projectDirectoryName;
    }

    // protected function setEnvironmentDirectoryName($value)
    // {
    //     if (!Validator::notEmpty()->alnum('-_')->noWhitespace()->validate($value)) {
    //         throw new HttpException('The environment directory name can contain only alphanumeric, dash and underscore characters', 400);
    //     }

    //     $this->environmentDirectoryName = $value;
    // }

    protected function getEnvironmentDirectoryName()
    {
        throw Exception('Rewrite');
        return $this->environmentDirectoryName;
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
            $statusManager = new RemoteStatusManager($this->getConnection(), $this->getScpConnection(), $this->getPermissionData());
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

    protected function loadPermissionData($parameters)
    {
        throw Exception('Rewrite');

        $permissions = $this->getParameterValue($parameters, 'permissions');

        if (!Validator::arrayType()->validate($permissions)) {
            throw new HttpException('The permissions parameter should be an array', 400);
        }

        foreach (['directory', 'file', 'config'] as $permissionParameter) {
            if (!array_key_exists($permissionParameter, $permissions)) {
                throw new HttpException(sprintf('The %s property is not found for permissions request parameter', $permissionParameter), 400);
            }
        }

        $this->permissionData = new RequestPermissionData(
            $permissions['directory'],
            $permissions['config'],
            $permissions['file']
        );
    }

    protected function getPermissionData()
    {
        throw Exception('Rewrite');

        if (!$this->permissionData) {
            throw new Exception('Permission data is not initialized');
        }

        return $this->permissionData;
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
            $this->getPermissionData()->getFileMask(),
            'log file'
        );
    }
}