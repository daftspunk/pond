<?php namespace Tests\Functional;

use Slim\App;
use Slim\Http\Request;
use Slim\Http\Response;
use Slim\Http\Environment;

use PHPUnit\Framework\TestCase;
use PhpDeployer\Ssh\Connection;

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

    protected function makeValidConnection()
    {
        $config = self::getConfig('connection');

        return new Connection($config['host'], 
            $config['publicKey'], 
            $config['privateKey'], 
            $config['user'], 
            $config['stringMask']);
    }

    protected function generateUniqueProjectName($pondRoot)
    {
        $nameBase = 'test-project-';
        $counter = 1;

        do {
            $name = $nameBase.$counter++;
        } while (is_dir($pondRoot.'/'.$name));

        return $name;
    }
}
