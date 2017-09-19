<?php namespace PhpDeployer\Operations;

use PhpDeployer\Exceptions\Http as HttpException;
use PhpDeployer\Operations\Configuration as ConfigurationOperation;
use PhpDeployer\Util\Configuration as DeployerConfiguration;
use Respect\Validation\Validator as Validator;
use PhpDeployer\Archiver\ProjectArchiver;
use Exception;

/**
 * Performs project deployment on a target server.
 *
 * If it's an update operation, we always update the inactive
 * deployment environment, e.g. if the currently active environment
 * is blue, we will deploy to green and vice versa.
 *
 * Target directory layout (rough and not complete, for reference only):
 *
 * /var/www/pond/projects
 *   /project1
 *     /production
 *       /config
 *       /blue
 *         /storage/app - (symlink to the common storage/app)
 *         /storage/framework/sessions - (symlink to the common storage/framework/sessions)
 *       /green
 *         /storage/app - (symlink to the common storage/app)
 *         /storage/framework/sessions - (symlink to the common storage/framework/sessions)
 *       /current (symlink to blue or green)
 *       /metadata
 *         /log
 *       /storage
 *         /app
 *         /framework
 *           /sessions
 *       /pond-tmp
 *     /staging
 *       ...
 */
class Deployment extends Base
{
    const DEFAULT_NEW_DEPLOYMENT_ENVIRONMENT = 'green';

    private $updatedDeploymentEnvironments = [];
    private $updatedComponents = [];

    // The following properties must stay private.
    // If they're set from external sources, their
    // values must be validated.

    private $update;
    private $localProjectPath;
    private $configurationOperation;
    private $buildTag;

    public function setDeploymentParameters($parameters)
    {
        $this->update = $this->getParameterValue($parameters, 'update');
        $this->localProjectPath = $this->getParameterValue($parameters, 'localProjectPath');

        $this->setProjectDirectoryName($this->getParameterValue($parameters, 'projectDirectoryName'));
        $this->setEnvironmentDirectoryName($this->getParameterValue($parameters, 'environmentDirectoryName'));

        if (!Validator::boolType()->validate($this->update)) {
            throw new HttpException('The update parameter should be of boolean type', 400);
        }

        if (!Validator::directory()->validate($this->localProjectPath)) {
            throw new HttpException('The local project directory not found', 400);
        }

        $this->buildTag = $this->getParameterValue($parameters, 'buildTag', false, '');
        if (!Validator::stringType()->length(null, 50)->validate($this->buildTag)) {
            throw new HttpException('The build tag must be a string of at most 50 characters length.', 400);
        }

        $configTemplatesProvided = $this->getParameterValue($parameters, 'configTemplates', false) !== null;
        if (!$this->update && !$configTemplatesProvided) {
            throw new HttpException('Configuration templates must be provided for the new deployment', 400);
        }

        if ($configTemplatesProvided) {
            // Create the configuration operation early to detect possible
            // problems with templates before deployment.

            $this->configurationOperation = new ConfigurationOperation(
                $this->getConnection(), 
                $this->getScpConnection());

            $this->configurationOperation->setConfigurationParameters($parameters);
        }
    }

    public function run()
    {
        if ($this->update) {
            $this->validateEnvironmentDirectories();
            $this->loadMetadata();
        }
        else {
            $this->initDirectories();
            $this->archiveUploadAndExtract(['blue', 'green']);
        }

        if ($this->configurationOperation) {
            $this->configurationOperation->run();
        }
    }

    public function saveRemoteStatus($success)
    {
        if ($success) {
            $deploymentEnvironmentsDetails = [];
            $remoteDateTime = $this->getConnection()->getRemoteDateTime();

            foreach ($this->updatedDeploymentEnvironments as $name) {
                $deploymentEnvironmentsDetails[$name] = [
                    'buildTag' => $this->buildTag,
                    'lastDeployment' => $remoteDateTime
                ];
            }
        }
        else {
            $deploymentEnvironmentsDetails = null;
        }

        $logRecordDetails = RemoteStatusManager::makeLogRecordArray(
            $success, 
            $this->updatedComponents, 
            $this->updatedDeploymentEnvironments);

        $this->updateRemoteStatus($logRecordDetails, $deploymentEnvironmentsDetails);
    }

    private function initDirectories()
    {
        $connection = $this->getConnection();

        if (!$connection->directoryExists(DeployerConfiguration::POND_ROOT)) {
            throw new Exception(sprintf('%s directory not found on the server $pondRoot', DeployerConfiguration::POND_ROOT));
        }

        // If we are creating the environment, make sure the 
        // environment's directory does not exist.

        $projectDirectory = $this->getProjectDirectoryRemotePath();
        $envDirectory = $this->getEnvironmentDirectoryRemotePath();

        if ($connection->directoryExists($envDirectory)) {
            throw new Exception(sprintf('The project environment directory already exists: %s', $envDirectory));
        }

        $commands = [
            'mkdir -m {{$dirMask}} -p "{{$projDirectory}}"',
            'mkdir -m {{$dirMask}} -p "{{$envDirectory}}"',
            'mkdir -m {{$dirMask}} -p "{{$envDirectory}}/config'.'"', 

            'mkdir -m {{$dirMask}} -p "{{$envDirectory}}/blue'.'"', 
            'mkdir -m {{$dirMask}} -p "{{$envDirectory}}/blue/storage/framework'.'"', 
            'mkdir -m {{$dirMask}} -p "{{$envDirectory}}/blue/storage/cms'.'"', 
            'ln -s "{{$envDirectory}}/storage/app" "{{$envDirectory}}/blue/storage/app'.'"',
            'ln -s "{{$envDirectory}}/storage/framework/sessions" "{{$envDirectory}}/blue/storage/framework/sessions'.'"',

            'mkdir -m {{$dirMask}} -p "{{$envDirectory}}/green'.'"', 
            'mkdir -m {{$dirMask}} -p "{{$envDirectory}}/green/storage/framework'.'"', 
            'mkdir -m {{$dirMask}} -p "{{$envDirectory}}/green/storage/cms'.'"', 
            'ln -s "{{$envDirectory}}/storage/app" "{{$envDirectory}}/green/storage/app'.'"',
            'ln -s "{{$envDirectory}}/storage/framework/sessions" "{{$envDirectory}}/green/storage/framework/sessions'.'"',

            'mkdir -m {{$dirMask}} -p "{{$envDirectory}}/metadata/log'.'"', 
            'mkdir -m {{$dirMask}} -p "{{$envDirectory}}/storage'.'"', 
            'mkdir -m {{$dirMask}} -p "{{$envDirectory}}/storage/framework/sessions'.'"', 
            'mkdir -m {{$dirMask}} -p "{{$envDirectory}}/storage/app/uploads/public'.'"', 
            'mkdir -m {{$dirMask}} -p "{{$envDirectory}}/storage/app/uploads/protected'.'"', 
            'mkdir -m {{$dirMask}} -p "{{$envDirectory}}/storage/app/media'.'"',
            'mkdir -m {{$dirMask}} -p "{{$envDirectory}}/pond-tmp'.'"',
            'ln -s "{{$envDirectory}}/{{$currentEnv}}" "{{$envDirectory}}/current'.'"'
        ];

        $variables = [
            'dirMask' => DeployerConfiguration::UNIX_DIRECTORY_MASK,
            'envDirectory' => $envDirectory,
            'projDirectory' => $projectDirectory,
            'currentEnv' => self::DEFAULT_NEW_DEPLOYMENT_ENVIRONMENT
        ];

        $connection->runMultipleCommands($commands, 10, $variables);
    }

    private function archiveUploadAndExtract($deploymentEnvironmentNames)
    {
        $deploymentEnvironmentNames = (array)$deploymentEnvironmentNames;
        $archiver = new ProjectArchiver($this->localProjectPath);
        $zipPath = $archiver->make();

        $this->updatedDeploymentEnvironments = $deploymentEnvironmentNames;
        $this->updatedComponents = $archiver->getArchivedComponents();

        try {
            $tmpFileName = $this->makeRemoteTempFileName();
            $envDirectory = $this->getEnvironmentDirectoryRemotePath();
            $destRemotePath = $envDirectory.'/pond-tmp/'.$tmpFileName;
            $connection = $this->getConnection();

            $this->getScpConnection()->upload($zipPath, $destRemotePath);

            if (!$connection->fileExists($destRemotePath)) {
                throw new Exception('Error uploading the archive');
            }

            try {
                foreach ($deploymentEnvironmentNames as $deploymentEnvironmentName) {
                    $unzipPath = $envDirectory.'/'.$deploymentEnvironmentName;
                    $params = [
                        'zipPath' => $destRemotePath,
                        'destPath' => $unzipPath
                    ];

                    $connection->runCommand('unzip -q -o "{{$zipPath}}" -d "{{$destPath}}"', 30, $params);

                    $this->fixPermissions($archiver, $unzipPath);
                }
            }
            finally {
                $connection->runCommand('rm '.$destRemotePath);
            }
        }
        finally {
            @unlink($zipPath);
        }
    }

    private function fixPermissions($archiver, $directory)
    {
        $connection = $this->getConnection();
        $archivedPaths = $archiver->getArchivedComponentPaths();
        foreach ($archivedPaths as $path) {
            $params = [
                'path' => $directory.'/'.$path,
                'fileMask' => DeployerConfiguration::UNIX_FILE_MASK,
                'dirMask' => DeployerConfiguration::UNIX_DIRECTORY_MASK
            ];

            if ($path != 'config') {
                // Permissions for configuration files are
                // managed with the configuration operation.
                $connection->runCommand('if [ -f "{{$path}}" ]; then find "{{$path}}" -type f -exec chmod {{$fileMask}} {} \;; fi', 120, $params);
            }

            $connection->runCommand('if [ -d "{{$path}}" ]; then find "{{$path}}" -type d -exec chmod {{$dirMask}} {} \;; fi', 120, $params);
        }
    }

    private function validateEnvironmentDirectories()
    {
        // If we are updating the environment make sure the
        // project and environment directories exist.
    }
}