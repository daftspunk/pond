<?php namespace PhpDeployer\Operations;

use PhpDeployer\Ssh\Connection;
use PhpDeployer\Exceptions\Http as HttpException;
use Respect\Validation\Validator as Validator;
use PhpDeployer\Util\Configuration as DeployerConfiguration;
use Exception;

/**
 * Base class for deployment and configuration operations.
 */
abstract class Base
{
    private $connection;
    private $scpConnection;

    protected $privateKeyPath;
    protected $publicKeyPath;
    protected $ip;
    protected $user;

    private $logCallable;
    private $combinedLog = [];

    // The following properties must stay private.
    // If they're set from external sources, their
    // values must be validated.

    private $projectDirectoryName;
    private $environmentDirectoryName;

    public function __construct(Connection $connection = null, Connection $scpConnection = null)
    {
        // This allows to reuse an existing connection when
        // the operation is used from inside of another 
        // operation.
        $this->connection = $connection;
        $this->scpConnection = $scpConnection;
    }

    /**
     * Sets the common connection parameters.
     *
     * All the parameters should be validated by the calling code.
     * For HTTP requests it's done in ControllerBase.
     */
    public function setConnectionParameters($privateKeyPath, $publicKeyPath, $ip, $user)
    {
        $this->privateKeyPath = $privateKeyPath;
        $this->publicKeyPath = $publicKeyPath;
        $this->ip = $ip;
        $this->user = $user;
    }

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

    public function saveRemoteStatus($logRecordDetails, $deploymentEnvironmentsDetails = null)
    {
        try {
            $this->uploadRemoteStatus($logRecordDetails, $deploymentEnvironmentsDetails);
        }
        catch (Exception $ex) {
            // This will push the message to the client
            $this->handleConnectionLogEntry(sprintf('Error updating environment status file on the server. %s', $ex->getMessage()));
        }
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

    protected function getParameterValue($params, $key, $required = true, $default = null)
    {
        if (!array_key_exists($key, $params)) {
            if ($required) {
                throw new HttpException(sprintf('Required parameter %s not found in the request', $key), 400);
            }

            return $default;
        }

        return $params[$key];
    }

    protected function setProjectDirectoryName($value)
    {
        if (!Validator::notEmpty()->alnum('-_')->noWhitespace()->validate($value)) {
            throw new HttpException('The project directory name can contain only alphanumeric, dash and underscore characters', 400);
        }

        $this->projectDirectoryName = $value;
    }

    protected function getProjectDirectoryName()
    {
        return $this->projectDirectoryName;
    }

    protected function setEnvironmentDirectoryName($value)
    {
        if (!Validator::notEmpty()->alnum('-_')->noWhitespace()->validate($value)) {
            throw new HttpException('The environment directory name can contain only alphanumeric, dash and underscore characters', 400);
        }

        $this->environmentDirectoryName = $value;
    }

    protected function getEnvironmentDirectoryName()
    {
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
        $localTmpPath = tempnam(sys_get_temp_dir(), 'pond_');
        try {
            $remoteTmpFileName = $this->makeRemoteTempFileName();

            if (file_put_contents($localTmpPath, implode("\n", $this->combinedLog)) === false) {
                throw new Exception('Error creating log file: cannot create a local temporary file');
            }

            $envDirectory = $this->getEnvironmentDirectoryRemotePath();
            $destRemotePath = $envDirectory.'/pond-tmp/'.$remoteTmpFileName;

            $connection = $this->getConnection();
            $this->getScpConnection()->upload($localTmpPath, $destRemotePath);

            if (!$connection->fileExists($destRemotePath)) {
                throw new Exception('Error uploading the log file');
            }

            try {
                $serverTime = $connection->runCommand('date +"%Y-%m-%dT%T"');
                $finalLogPath = $envDirectory.'/metadata/log/'.$serverTime.'.txt';

                $params = [
                    'tmpPath' => $destRemotePath,
                    'destPath' => $finalLogPath,
                    'mask' => DeployerConfiguration::UNIX_FILE_MASK
                ];

                $connection->runCommand('mv "{{$tmpPath}}" "{{$destPath}}"', 30, $params);
                $this->getConnection()->runCommand('chmod {{$mask}} "{{$destPath}}"', 10,  $params);
            }
            finally {
                $connection->runCommand('rm '.$destRemotePath);
            }
        }
        finally {
            @unlink($localTmpPath);
        }
    }

    private function uploadRemoteStatus($logRecordDetails, $deploymentEnvironmentsDetails)
    {
        // Download and parse the existing status file /metadata/status.json
        // Merge with the log record details, remove old entries
        // Merge with deploymentEnvironmentsDetails
        // Upload and chmod
    }

    abstract public function run();
}