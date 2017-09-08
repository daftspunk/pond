<?php namespace PhpDeployer\Operations;

use PhpDeployer\Exceptions\Http as HttpException;
use Respect\Validation\Validator as Validator;
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
 *     /staging
 *       ...
 */
class Deployment extends Base
{
    const POND_ROOT = '/var/www';

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
        if ($this->update) {
            $this->validateEnvironmentDirectories();
            $this->loadMetadata();
        }
        else {
            $this->initDirectories();

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

        $projectDirectory = self::POND_ROOT.'/'.$this->projectDirectoryName;
        $envDirectory = self::POND_ROOT.'/'.$this->projectDirectoryName.'/'.$this->environmentDirectoryName;

        if ($connection->directoryExists($envDirectory)) {
            throw new Exception(sprintf('The project environment directory already exists: %s', $envDirectory));
        }

        // TODO: create /storage/app, /storage/framework/sessions symlinks

        $commands = [
            'mkdir -m '.$this->unixDirectoryMask.' -p "'.$projectDirectory.'"',     // Create project directory
            'mkdir -m '.$this->unixDirectoryMask.' -p "'.$envDirectory.'"',         // Create environment directory
            'mkdir -m '.$this->unixDirectoryMask.' -p "'.$envDirectory.'/config'.'"', 
            'mkdir -m '.$this->unixDirectoryMask.' -p "'.$envDirectory.'/blue'.'"', 
            'mkdir -m '.$this->unixDirectoryMask.' -p "'.$envDirectory.'/green'.'"', 
            'mkdir -m '.$this->unixDirectoryMask.' -p "'.$envDirectory.'/metadata'.'"', 
            'mkdir -m '.$this->unixDirectoryMask.' -p "'.$envDirectory.'/storage'.'"', 
            'mkdir -m '.$this->unixDirectoryMask.' -p "'.$envDirectory.'/storage/framework/sessions'.'"', 
            'mkdir -m '.$this->unixDirectoryMask.' -p "'.$envDirectory.'/storage/app/uploads/public'.'"', 
            'mkdir -m '.$this->unixDirectoryMask.' -p "'.$envDirectory.'/storage/app/uploads/protected'.'"', 
            'mkdir -m '.$this->unixDirectoryMask.' -p "'.$envDirectory.'/storage/app/media'.'"', 
            'ln -s "'.$envDirectory.'/green'.'" "'.$envDirectory.'/current'.'"'
        ];

        $connection->runMultipleCommands($commands);
    }

    private function validateEnvironmentDirectories()
    {
        // If we are updating the environment make sure the
        // project and environment directories exist.
    }
}