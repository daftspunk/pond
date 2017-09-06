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
 * Target directory layout:
 *
 * /var/www/pond/projects
 *   /project1
 *     /production
 *       /config
 *       /blue
 *         /storage - (symlink to the common storage)
 *       /green
 *         /storage - (symlink to the common storage)
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

    private $unixDirectoryMask = "755"; 
    private $unixFileMask = "644";

    public function setDeploymentParameters($update, $projectDirectoryName, $environmentDirectoryName)
    {
        $this->update = $update;
        $this->projectDirectoryName = $projectDirectoryName;
        $this->environmentDirectoryName = $environmentDirectoryName;

        if (!Validator::boolType()->validate($this->update)) {
            throw new HttpException('The update parameter should be of boolean type', 400);
        }

        if (!Validator::notEmpty()->alnum('-_')->noWhitespace()->validate($this->projectDirectoryName)) {
            throw new HttpException('The project directory name can contain only alphanumeric, dash and underscore characters', 400);
        }

        if (!Validator::notEmpty()->alnum('-_')->noWhitespace()->validate($this->environmentDirectoryName)) {
            throw new HttpException('The environment directory name can contain only alphanumeric, dash and underscore characters', 400);
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
            'mkdir -m '.$this->unixDirectoryMask.' -p "'.$envDirectory.'/storage/app/media'.'"', 
            'ln -s "'.$envDirectory.'/blue'.'" "'.$envDirectory.'/green'.'"'
        ];
    }

    private function validateEnvironmentDirectories()
    {
        // If we are updating the environment make sure the
        // project and environment directories exist.

    }
}