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
 *       /current (symlink)
 *       /metadata
 *         log
 *       /storage
 *         /app
 *         /framework
 *           /sessions
 *
 */
class Deployment extends Base
{
    const POND_ROOT = '/var/www';

    private $update;
    private $projectDirectoryName;
    private $environmentDirectoryName;

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
        // environment's directory does not exist. If the
        // project directory does not exist yet - create it.

        $projectDirectory = self::POND_ROOT.'/'.$this->projectDirectoryName;
        $environmentDirectory = self::POND_ROOT.'/'.$this->projectDirectoryName.'/'.$this->environmentDirectoryName;

        if ($connection->directoryExists($environmentDirectory)) {
// FAIL HERE
        }


        if (!$connection->directoryExists($projectDirectory)) {
// RUN MULTI COMMANDS HERE
        }
    }

    private function validateEnvironmentDirectories()
    {
        // If we are updating the environment make sure the
        // project and environment directories exist.

    }
}