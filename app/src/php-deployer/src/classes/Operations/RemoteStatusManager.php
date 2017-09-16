<?php namespace PhpDeployer\Operations;

class RemoteStatusManager
{
    const LOG_DAYS_TO_KEEP = 30;

    private $connection;
    private $scpConnection;

    public function __construct($connection, $scpConnection)
    {
        $this->connection = $connection
        $this->scpConnection = $scpConnection;
    }

    public function updateStatus($envDirectory, $logRecordDetails, $deploymentEnvironmentsDetails)
    {
        $remoteFilePath = $envDirectory.'/metadata/status.json';
        $jsonContents = $this->downloadAndParse($remoteFilePath);

        if ($deploymentEnvironmentsDetails) {
            if (!isset($jsonContents['deploymentEnvironments'])) {
                $jsonContents['deploymentEnvironments'] = [];
            }

            $jsonContents['deploymentEnvironments'] = array_merge_recursive($jsonContents['deploymentEnvironments'], $deploymentEnvironmentsDetails;);
        }

        // TODO - process log in a separate method
        if ($logRecordDetails) {
            if (!array_key_exists('deploymentLog', $jsonContents)) {
                $jsonContents['deploymentLog'] = [];
            }

            $logRecordDetails['datetime'] = $this->connection->runCommand('date +"%Y-%m-%dT%T"');
            $logRecordDetails['ip'] = $this->connection->getClientIp();

            $jsonContents['deploymentLog'][] = $logRecordDetails;
        }

        if (array_key_exists('deploymentLog', $jsonContents)) {
            $jsonContents['deploymentLog'] = $this->remoteOldLogEntries($jsonContents['deploymentLog']);
        }

        $jsonString = json_encode($jsonContents);

        $remoteTmpDir = $envDirectory.'/pond-tmp';

        $this->getScpConnection()->uploadFromString(
            $commandConnection, 
            $jsonString, 
            $remoteFilePath, 
            $remoteTmpDir, 
            DeployerConfiguration::UNIX_FILE_MASK
        );
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
}