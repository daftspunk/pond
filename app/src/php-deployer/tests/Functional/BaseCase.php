<?php namespace Tests\Functional;

use Slim\App;
use Slim\Http\Request;
use Slim\Http\Response;
use Slim\Http\Environment;

use PHPUnit\Framework\TestCase;
use PhpDeployer\Ssh\Connection;
use PhpDeployer\Util\Configuration as DeployerConfiguration;
use PhpDeployer\Operations\Deployment as DeploymentOperation;

use Exception;
use PDO;

/**
 * This is an example class that shows how you could set up a method that
 * runs the application. Note that it doesn't cover all use-cases and is
 * tuned to the specifics of this skeleton app, so if your needs are
 * different, you'll need to change it.
 */
class BaseCase extends TestCase
{
    private static $configValues;

    /**
     * Use middleware when running application?
     *
     * @var bool
     */
    protected $withMiddleware = true;

    public static function setUpBeforeClass()
    {
        self::$configValues = json_decode(file_get_contents(__DIR__.'/../fixtures/config.json'), true);
    }

    protected static function getConfig($name)
    {
        return self::$configValues[$name];
    }

    /**
     * Process the application given a request method and URI
     *
     * @param string $requestMethod the request method (e.g. GET, POST, etc.)
     * @param string $requestUri the request URI
     * @param callable $requestSetupCallback callable function for setting up the request properties
     * @return \Slim\Http\Response
     */
    public function runApp($requestMethod, $requestUri, callable $requestSetupCallback = null)
    {
        // Create a mock environment for testing with
        $environment = Environment::mock(
            [
                'REQUEST_METHOD' => $requestMethod,
                'REQUEST_URI' => $requestUri
            ]
        );

        // Set up a request object based on the environment
        $request = Request::createFromEnvironment($environment);

        // Add request data, if it exists
        if (isset($requestSetupCallback)) {
            $requestSetupCallback($request);
        }

        // Set up a response object
        $response = new Response();

        // Use the application settings
        $settings = require __DIR__ . '/../../src/settings.php';

        // Instantiate the application
        $app = new App($settings);

        // Set up dependencies
        require __DIR__ . '/../../src/dependencies.php';

        // Register middleware
        if ($this->withMiddleware) {
            require __DIR__ . '/../../src/middleware.php';
        }

        // Register routes
        require __DIR__ . '/../../src/routes.php';

        // Process the application
        $response = $app->process($request, $response);

        // Return the response
        return $response;
    }

    protected function makeDatabase()
    {
        $dbh = $this->connectToDb(null);

        do {
            $dbName = uniqid('ponddb');
            $sql = sprintf('SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = "%s"', $dbName);
        } while ($dbh->query($sql)->rowCount() > 0);

        $dbName = uniqid('ponddb');
        $dbh->exec(sprintf('CREATE DATABASE `%s`;', $dbName));

        return $dbName;
    }

    protected function connectToDb($dbName)
    {
        $config = self::getConfig('database');
        $dsn = 'mysql:host='.$config['host'];

        if ($dbName) {
            $dsn .= ';dbname='.$dbName;
        }

        return new PDO($dsn, $config['user'], $config['password']);
    }

    protected function doesTableExist($connection, $dbName, $tableName)
    {
        $sql = sprintf('SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = "%s" AND TABLE_NAME = "%s" LIMIT 1', $dbName, $tableName);

        $statement = $connection->query($sql);
        if ($statement === false) {
            throw new Exception('Error executing SQL statement. '.$connection->errorInfo()[2]);
        }

        return $statement->rowCount() > 0;
    }

    protected function getTableRowCount($connection, $tableName)
    {
        $sql = sprintf('SELECT * FROM %s', $tableName);

        $statement = $connection->query($sql);
        if ($statement === false) {
            throw new Exception('Error executing SQL statement. '.$connection->errorInfo()[2]);
        }

        return $statement->rowCount();
    }

    protected function makeValidConnection()
    {
        $config = self::getConfig('connection');

        return new Connection($config['host'], 
            $config['publicKey'], 
            $config['privateKey'], 
            $config['user'], 
            $config['stringMask']);
    }

    protected function generateUniqueProjectName()
    {
        $pondRoot = DeployerConfiguration::POND_ROOT;
        $nameBase = 'test-project-';
        $counter = 1;

        do {
            $name = $nameBase.$counter++;
        } while (is_dir($pondRoot.'/'.$name));

        return $name;
    }

    protected function generateUniqueEnvironmentName($projectName)
    {
        $pondRoot = DeployerConfiguration::POND_ROOT;
        $nameBase = 'test-environment-';
        $counter = 1;

        do {
            $name = $nameBase.$counter++;
        } while (is_dir($pondRoot.'/'.$projectName.'/'.$name));

        return $name;
    }

    protected function makeValidDeploymentConfig($updateRequest = false)
    {
        $config = self::getConfig('connection');
        $projectName = $this->generateUniqueProjectName();

        $result = [
            'privateKeyPath' => $config['privateKey'],
            'publicKeyPath' => $config['publicKey'],
            'ip' => $config['host'],
            'user' => $config['user'],
            'params' => [
                'update' => false,
                'projectDirectoryName' => $projectName,
                'environmentDirectoryName' => $this->generateUniqueEnvironmentName($projectName),
                'localProjectPath' => __DIR__.'/../fixtures/test-project',
                'permissions' => [
                    'directory' => '755',
                    'file' => '664',
                    'config' => '660'
                ],
                'configTemplates' => [],
                'scripts' => []
            ]
        ];

        if ($updateRequest) {
            $result['params']['update'] = true;
            $result['params']['updateComponents'] = [
                'core'=>true, 
                'media'=>true,
                'uploads'=>true,
                'plugins'=>true,
                'themes'=>true,
            ];
        }
        else {
            $result['params']['databaseInit'] = [
                "initDatabase" => false
            ];
        }

        return $result;
    }

    protected function makePostDeploymentScriptItem($name)
    {
        return [
            'type' => 'post-deployment',
            'contents' => file_get_contents(__DIR__.'/../fixtures/test-scripts/'.$name)
        ];
    }

    protected function makeDatabaseInitParams()
    {
        return [
            "initDatabase" => true,
            "dump" => "dump-string",
            "engine" => "mysql",
            "connection" => [
                "host" => "127.0.0.1",
                "user" => "app",
                "password" => "password",
                "port" => 3306,
                "name" => "database"
            ]
        ];
    }

    protected function makeDir($path)
    {
        if (!mkdir($path, 0777, true)) {
            throw new Exception('Error creating test directory');
        }
    }

    protected function runDeploymentRequest($params, $operation = '/deploy')
    {
        return $this->runApp('POST', $operation, function($request) use ($params) {
            $request->withHeader('Content-Type', 'application/json');

            $request->getBody()->write(json_encode($params));
        });
    }

    protected function loadTestConfigTemplates($sourceDir, $namesAndParameters)
    {
        $result = [];

        foreach ($namesAndParameters as $name=>$parameters) {
            $path = $sourceDir.'/'.$name;
            $contents = file_get_contents($path);
            if ($contents === false) {
                throw new Exception(sprintf('Error loading fixture configuration file: %s', $path));
            }

            $paramsArray = [];
            foreach ($parameters as $paramName=>$paramValue) {
                $paramsArray[] = [
                    'name' => $paramName,
                    'value' => $paramValue
                ];
            }

            $result[] = [
                'file' => $name,
                'template' => $contents,
                'vars' => $paramsArray
            ];
        }

        return $result;
    }
}
