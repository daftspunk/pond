<?php namespace PhpDeployer\Operations\Misc;

use PhpDeployer\Exceptions\Http as HttpException;
use Respect\Validation\Validator as Validator;

class DatabaseInitializer
{
    // The following properties must stay private.
    // If they're set from external sources, their
    // values must be validated.

    private $connection;
    private $scpConnection;
    private $permissionData;

    public function __construct($connection, $scpConnection, $permissionData, $parameters)
    {
        $this->connection = $connection;
        $this->scpConnection = $scpConnection;
        $this->permissionData = $permissionData;

        $this->setParameters($parameters);
    }

    private function setParameters($parameters)
    {
        if (!Validator::arrayType()->validate($parameters)) {
            throw new HttpException('The databaseInit parameter should be an array', 400);
        }

        if (!array_key_exists('initDatabase', $parameters)) {
            throw new HttpException('The databaseInit.initDatabase parameter is required', 400);
        }
        
        if (!Validator::boolType()->validate($parameters['initDatabase'])) {
            throw new HttpException('The databaseInit.initDatabase parameter should be of boolean type', 400);
        }

        if (!$parameters['initDatabase']) {
            return;
        }

        if (!array_key_exists('engine', $parameters)) {
            throw new HttpException('The databaseInit.engine parameter is required', 400);
        }

        if ()

        // "initDatabase": true,
        // "engine": "mysql",
        // "dumpPath": "/path/to/database/dump.sql",
        // "connection": {
        //     "host": "localhost",
        //     "user": "username",
        //     "password": "password",
        //     "port": 3306,
        //     "name": "my-database"
        // }
    }
}