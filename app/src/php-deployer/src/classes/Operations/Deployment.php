<?php namespace PhpDeployer\Operations;

use PhpDeployer\Exceptions\Http as HttpException;
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
 *         log
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
    const POND_ROOT = '/var/www';

    const DEFAULT_NEW_DEPLOYMENT_ENVIRONMENT = 'green';

    // The following properties must stay private.
    // If they're set from external sources, their
    // values must be validated.

    private $update;
    private $projectDirectoryName;
    private $environmentDirectoryName;
    private $localProjectPath;

    private $unixDirectoryMask = "755"; 
    private $unixFileMask = "644";

    public function setDeploymentParameters($parameters)
    {
        $this->update = $this->getParameterValue($parameters, 'update');
        $this->projectDirectoryName = $this->getParameterValue($parameters, 'projectDirectoryName');
        $this->environmentDirectoryName = $this->getParameterValue($parameters, 'environmentDirectoryName');
        $this->localProjectPath = $this->getParameterValue($parameters, 'localProjectPath');

        if (!Validator::boolType()->validate($this->update)) {
            throw new HttpException('The update parameter should be of boolean type', 400);
        }

        if (!Validator::notEmpty()->alnum('-_')->noWhitespace()->validate($this->projectDirectoryName)) {
            throw new HttpException('The project directory name can contain only alphanumeric, dash and underscore characters', 400);
        }

        if (!Validator::notEmpty()->alnum('-_')->noWhitespace()->validate($this->environmentDirectoryName)) {
            throw new HttpException('The environment directory name can contain only alphanumeric, dash and underscore characters', 400);
        }

        if (!Validator::directory()->validate($this->localProjectPath)) {
            throw new HttpException('The local project directory not found', 400);
        }
    }

    public function run()
    {
        // TODO: remove temporary files in the end

        if ($this->update) {
            $this->validateEnvironmentDirectories();
            $this->loadMetadata();
        }
        else {
            $this->initDirectories();
            $this->archiveUploadAndExtract(['blue', 'green']);
        }
    }

    private function initDirectories()
    {
        $connection = $this->getConnection();

        if (!$connection->directoryExists(self::POND_ROOT)) {
            throw new Exception(sprintf('%s directory not found on the server $pondRoot', self::POND_ROOT));
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
            'ln -s "{{$envDirectory}}/storage/app" "{{$envDirectory}}/blue/storage/app'.'"',
            'ln -s "{{$envDirectory}}/storage/framework/sessions" "{{$envDirectory}}/blue/storage/framework/sessions'.'"',

            'mkdir -m {{$dirMask}} -p "{{$envDirectory}}/green'.'"', 
            'mkdir -m {{$dirMask}} -p "{{$envDirectory}}/green/storage/framework'.'"', 
            'ln -s "{{$envDirectory}}/storage/app" "{{$envDirectory}}/green/storage/app'.'"',
            'ln -s "{{$envDirectory}}/storage/framework/sessions" "{{$envDirectory}}/green/storage/framework/sessions'.'"',

            'mkdir -m {{$dirMask}} -p "{{$envDirectory}}/metadata'.'"', 
            'mkdir -m {{$dirMask}} -p "{{$envDirectory}}/storage'.'"', 
            'mkdir -m {{$dirMask}} -p "{{$envDirectory}}/storage/framework/sessions'.'"', 
            'mkdir -m {{$dirMask}} -p "{{$envDirectory}}/storage/app/uploads/public'.'"', 
            'mkdir -m {{$dirMask}} -p "{{$envDirectory}}/storage/app/uploads/protected'.'"', 
            'mkdir -m {{$dirMask}} -p "{{$envDirectory}}/storage/app/media'.'"',
            'mkdir -m {{$dirMask}} -p "{{$envDirectory}}/pond-tmp'.'"',
            'ln -s "{{$envDirectory}}/{{$currentEnv}}" "{{$envDirectory}}/current'.'"'
        ];

        $variables = [
            'dirMask' => $this->unixDirectoryMask,
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
                    $params = [
                        'zipPath' => $destRemotePath,
                        'destPath' => $envDirectory.'/'.$deploymentEnvironmentName
                    ];

                    $connection->runCommand('unzip -o "{{$zipPath}}" -d "{{$destPath}}"', 30, $params);
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

    private function getProjectDirectoryRemotePath()
    {
        return self::POND_ROOT.'/'.$this->projectDirectoryName;
    }

    private function getEnvironmentDirectoryRemotePath()
    {
        return $this->getProjectDirectoryRemotePath().'/'.$this->environmentDirectoryName;
    }

    private function makeRemoteTempFileName()
    {
        $result = microtime(true);

        return str_replace('.', '-', $result);
    }

    private function validateEnvironmentDirectories()
    {
        // If we are updating the environment make sure the
        // project and environment directories exist.
    }
}