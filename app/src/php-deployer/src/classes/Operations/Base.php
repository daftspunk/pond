<?php namespace PhpDeployer\Operations;

use PhpDeployer\Ssh\Connection;
use PhpDeployer\Exceptions\Http as HttpException;

/**
 * Base class for deployment and configuration operations.
 */
abstract class Base
{
    private $connection;

    protected $privateKeyPath;
    protected $publicKeyPath;
    protected $ip;
    protected $user;

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

    protected function getConnection()
    {
        if (!$this->connection) {
            $this->connection = new Connection(
                $this->ip, 
                $this->publicKeyPath,
                $this->privateKeyPath,
                $this->user);
        }

        return $this->connection;
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

    abstract public function run();
}