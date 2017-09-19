<?php namespace PhpDeployer\Operations;

use PhpDeployer\Util\Configuration as DeployerConfiguration;

class RemoteStatusManager
{
    const LOG_DAYS_TO_KEEP = 30;

    private $connection;
    private $scpConnection;

    public function __construct($connection, $scpConnection)
    {
        $this->connection = $connection;
        $this->scpConnection = $scpConnection;
    }

    public function updateStatus($envDirectory, $logRecordDetails, $deploymentEnvironmentsDetails)
    {
        $remoteFilePath = $envDirectory.'/metadata/status.json';
        $jsonContents = $this->downloadAndParse($remoteFilePath);

        $this->mergeDeploymentEnvironmentDefails($jsonContents, $deploymentEnvironmentsDetails);
        $this->updateDeploymentLog($jsonContents, $logRecordDetails);

        $jsonString = json_encode($jsonContents);
        $remoteTmpDir = $envDirectory.'/pond-tmp';

        $this->scpConnection->uploadFromString(
            $this->connection, 
            $jsonString, 
            $remoteFilePath, 
            $remoteTmpDir, 
            DeployerConfiguration::UNIX_FILE_MASK
        );
    }

    public static function makeLogRecordArray(bool $success, array $components, array $environments)
    {
        return [
            'status' => $success ? 'success' : 'fail',
            'components' => $components,
            'environment' => $environments,
        ];
    }

    private function remoteOldLogEntries($logEntries)
    {
        $result = [];
        $currentTime = time();
        $ttlInSeconds = self::LOG_DAYS_TO_KEEP*86400;

        foreach ($logEntries as $logEntry) {
            if (!isset($logEntry['datetime'])) {
                $result[] = $logEntry;
                continue;
            }

            $timestamp = @strtotime($logEntry['datetime']);
            if ($timestamp === false) {
                $result[] = $logEntry;
                continue;
            }

            if (($currentTime - $timestamp) > $ttlInSeconds) {
                continue;
            }

            $result[] = $logEntry;
        }

        return $result;
    }

    private function downloadAndParse($remoteFilePath)
    {
        if (!$this->connection->fileExists($remoteFilePath)) {
            return [];
        }

        $remoteFileContents = $this->connection->runCommand('cat {{$path}}', 10, ['path'=>$remoteFilePath]);

        if (!strlen($remoteFileContents)) {
            return [];
        }

        $result = @json_decode($remoteFileContents, true);
        if ($result === null) {
            return [];
        }

        return $result;
    }

    private function updateDeploymentLog(&$jsonContents, $newEntry)
    {
        if ($newEntry) {
            if (!array_key_exists('deploymentLog', $jsonContents)) {
                $jsonContents['deploymentLog'] = [];
            }

            $newEntry['datetime'] = $this->connection->getRemoteDateTime();
            $newEntry['ip'] = $this->connection->getClientIp();

            $jsonContents['deploymentLog'][] = $newEntry;
        }

        if (array_key_exists('deploymentLog', $jsonContents)) {
            $jsonContents['deploymentLog'] = $this->remoteOldLogEntries($jsonContents['deploymentLog']);
        }
    }

    private function mergeDeploymentEnvironmentDefails(&$jsonContents, $deploymentEnvironmentsDetails)
    {
        if (!$deploymentEnvironmentsDetails) {
            return;
        }

        if (!isset($jsonContents['deploymentEnvironments'])) {
            $jsonContents['deploymentEnvironments'] = [];
        }

        $merged = array_merge_recursive($jsonContents['deploymentEnvironments'], $deploymentEnvironmentsDetails);
        $jsonContents['deploymentEnvironments'] = $merged;
    }
}