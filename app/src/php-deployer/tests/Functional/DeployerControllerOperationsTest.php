<?php namespace Tests\Functional;

use PhpDeployer\Operations\Deployment as DeploymentOperation;
use PhpDeployer\Util\Configuration as DeployerConfiguration;
use Exception;

class DeployerControllerOperationTest extends BaseCase
{
    public function testNewDeploymentEnviromentDirectoryExists()
    {
        $params = $this->makeValidDeploymentConfig();
        $pondRoot = DeployerConfiguration::POND_ROOT;

        $environmentDirectory = $pondRoot.'/'.
            $params['params']['projectDirectoryName'].'/'.
            $params['params']['environmentDirectoryName'];

        $this->assertDirectoryNotExists($environmentDirectory);
        $this->makeDir($environmentDirectory);
        $this->assertDirectoryExists($environmentDirectory);

        $response = $this->runDeploymentRequest($params);

        $this->assertEquals(500, $response->getStatusCode());
        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('general', $responseBody->type);
        $this->assertContains('directory already exists', $responseBody->error);
    }

    public function testNewDeploymentPartialProjectNoErrors()
    {
        $params = $this->makeValidDeploymentConfig();
        $params['params']['localProjectPath'] = __DIR__.'/../fixtures/partial-test-project';
        $params['params']['buildTag'] = 'first-build';

        $templatesParams = [
            'app.php' => ['value'=>'true'],
            'view.php' => ['value'=>'"string"']
        ];

        $params['params']['configTemplates'] = $this->loadTestConfigTemplates(__DIR__.'/../fixtures/test-config', $templatesParams);

        $pondRoot = DeployerConfiguration::POND_ROOT;

        $environmentDirectory = $pondRoot.'/'.
            $params['params']['projectDirectoryName'].'/'.
            $params['params']['environmentDirectoryName'];

        echo PHP_EOL.'Partial deployment environment directory: '.$environmentDirectory.PHP_EOL;

        $this->assertDirectoryNotExists($environmentDirectory);

        $response = $this->runDeploymentRequest($params);
        // print_r((string)$response->getBody());
        $this->assertEquals(200, $response->getStatusCode());
        $responseBody = json_decode((string)$response->getBody());
        // $this->assertNotNull($responseBody); Should not be null, should return the actual log of commands and responses

        $this->assertDirectoryExists($environmentDirectory.'/config');
        $this->assertDirectoryExists($environmentDirectory.'/blue');
        $this->assertDirectoryExists($environmentDirectory.'/green');
        $this->assertDirectoryExists($environmentDirectory.'/metadata');
        $this->assertDirectoryExists($environmentDirectory.'/metadata/log');
        $this->assertDirectoryExists($environmentDirectory.'/storage');
        $this->assertDirectoryExists($environmentDirectory.'/storage/app');

        $connection = $this->makeValidConnection();
        $fileCount = $connection->runCommand('ls "{{$path}}" -1 | wc -l', 10, ['path'=>$environmentDirectory.'/metadata/log']);
        $this->assertEquals(1, $fileCount);

        $this->assertTrue(is_link($environmentDirectory.'/current'));
        $this->assertEquals($environmentDirectory.'/green', readlink($environmentDirectory.'/current'));

        $this->assertTrue(is_link($environmentDirectory.'/blue/storage/app'));
        $this->assertEquals($environmentDirectory.'/storage/app', readlink($environmentDirectory.'/blue/storage/app'));
        $this->assertTrue(is_link($environmentDirectory.'/blue/storage/framework/sessions'));
        $this->assertEquals($environmentDirectory.'/storage/framework/sessions', readlink($environmentDirectory.'/blue/storage/framework/sessions'));

        $this->assertTrue(is_link($environmentDirectory.'/green/storage/app'));
        $this->assertEquals($environmentDirectory.'/storage/app', readlink($environmentDirectory.'/green/storage/app'));
        $this->assertTrue(is_link($environmentDirectory.'/green/storage/framework/sessions'));
        $this->assertEquals($environmentDirectory.'/storage/framework/sessions', readlink($environmentDirectory.'/green/storage/framework/sessions'));

        $this->assertFileExists($environmentDirectory.'/green/index.php');
        $this->assertFileExists($environmentDirectory.'/green/plugins/october/demo/Plugin.php');

        $this->assertFileExists($environmentDirectory.'/blue/index.php');
        $this->assertFileExists($environmentDirectory.'/blue/plugins/october/demo/Plugin.php');

        $this->assertFileExists($environmentDirectory.'/config/app.php');
        $this->assertFileExists($environmentDirectory.'/config/view.php');

        $fileContents = $connection->runCommand('cat "{{$path}}"', 10, ['path'=>$environmentDirectory.'/config/app.php']);
        $this->assertEquals('<?php return [\'param1\' => true];', $fileContents);

        $fileContents = $connection->runCommand('cat "{{$path}}"', 10, ['path'=>$environmentDirectory.'/config/view.php']);
        $this->assertEquals('<?php return [\'param2\' => "string"];', $fileContents);

        $this->assertEquals(DeployerConfiguration::getUnixConfigFileMask(), substr(sprintf('%o', fileperms($environmentDirectory.'/config/app.php')), -3));
        $this->assertEquals(DeployerConfiguration::UNIX_FILE_MASK, substr(sprintf('%o', fileperms($environmentDirectory.'/blue/index.php')), -3));
        $this->assertEquals(DeployerConfiguration::UNIX_DIRECTORY_MASK, substr(sprintf('%o', fileperms($environmentDirectory.'/blue/plugins/october')), -3));

        $this->assertFileExists($environmentDirectory.'/metadata/status.json');
        $statusContents = json_decode(file_get_contents($environmentDirectory.'/metadata/status.json'), true);

        $this->assertNotNull($statusContents);
        $this->assertInternalType('array', $statusContents);
        $this->assertArrayHasKey('deploymentEnvironments', $statusContents);
        $this->assertArrayHasKey('deploymentLog', $statusContents);
        $this->assertTrue(isset($statusContents['deploymentEnvironments']['blue']));
        $this->assertTrue(isset($statusContents['deploymentEnvironments']['green']));
        $this->assertTrue(isset($statusContents['deploymentEnvironments']['green']['buildTag']));
        $this->assertTrue(isset($statusContents['deploymentLog'][0]['status']));
        $this->assertTrue(isset($statusContents['deploymentLog'][0]['components']));
        $this->assertInternalType('array', $statusContents['deploymentLog'][0]['components']);
        $this->assertEquals('first-build', $statusContents['deploymentEnvironments']['green']['buildTag']);
        $this->assertEquals('success', $statusContents['deploymentLog'][0]['status']);

        $this->assertContains('core', $statusContents['deploymentLog'][0]['components']);
        $this->assertContains('media', $statusContents['deploymentLog'][0]['components']);
        $this->assertContains('uploads', $statusContents['deploymentLog'][0]['components']);
        $this->assertContains('plugins', $statusContents['deploymentLog'][0]['components']);
        $this->assertContains('themes', $statusContents['deploymentLog'][0]['components']);
        $this->assertContains('config', $statusContents['deploymentLog'][0]['components']);

        return [
            'params'=>$params, 
            'environmentDirectory'=>$environmentDirectory
        ];
    }

    public function testFullDeployment()
    {
        if (getenv('TEST_FULL_DEPLOYMENT') != 'true') {
            $message = 'Ignoring full deployment test to save time. Use TEST_FULL_DEPLOYMENT=true environment variable to force the test.';
            echo PHP_EOL.$message.PHP_EOL;
            $this->markTestSkipped($message);
        }

        $params = $this->makeValidDeploymentConfig();

        $templatesParams = [
            'app.php' => [],
            'broadcasting.php' => [],
            'cache.php' => [],
            'cms.php' => [],
            'database.php' => [],
            'filesystems.php' => [],
            'mail.php' => [],
            'queue.php' => [],
            'services.php' => [],
            'session.php' => [],
            'view.php' => []
        ];

        $params['params']['localProjectPath'] = __DIR__.'/../fixtures/test-project';
        $params['params']['configTemplates'] = $this->loadTestConfigTemplates(__DIR__.'/../fixtures/test-config-full', $templatesParams);

        $pondRoot = DeployerConfiguration::POND_ROOT;
        $environmentDirectory = $pondRoot.'/'.
            $params['params']['projectDirectoryName'].'/'.
            $params['params']['environmentDirectoryName'];

        $this->assertDirectoryNotExists($environmentDirectory);

        $response = $this->runDeploymentRequest($params);
        // print_r((string)$response->getBody());
        $this->assertEquals(200, $response->getStatusCode());

        if (file_exists('/var/www/latest-deployment-environment')) {
            unlink('/var/www/latest-deployment-environment');
        }

        symlink($environmentDirectory, '/var/www/latest-deployment-environment');

        echo PHP_EOL.'Full deployment environment directory: '.$environmentDirectory.PHP_EOL;
        echo 'Visit dev-latest-deployed-environment.com to see the latest deployment.'.PHP_EOL;
    }

    /**
     * @depends testNewDeploymentPartialProjectNoErrors
     */
    public function testConfigurationOperation($input)
    {
        extract($input);

        $templatesParams = [
            'session.php' => ['value'=>'false']
        ];

        $params['params']['configTemplates'] = $this->loadTestConfigTemplates(__DIR__.'/../fixtures/test-config', $templatesParams);

        $response = $this->runDeploymentRequest($params, '/configure');
        // print_r((string)$response->getBody());
        $this->assertEquals(200, $response->getStatusCode());

        $this->assertFileExists($environmentDirectory.'/config/app.php');
        $this->assertFileExists($environmentDirectory.'/config/view.php');
        $this->assertFileExists($environmentDirectory.'/config/session.php');

        $connection = $this->makeValidConnection();

        $fileContents = $connection->runCommand('cat "{{$path}}"', 10, ['path'=>$environmentDirectory.'/config/app.php']);
        $this->assertEquals('<?php return [\'param1\' => true];', $fileContents);

        $fileContents = $connection->runCommand('cat "{{$path}}"', 10, ['path'=>$environmentDirectory.'/config/view.php']);
        $this->assertEquals('<?php return [\'param2\' => "string"];', $fileContents);

        $fileContents = $connection->runCommand('cat "{{$path}}"', 10, ['path'=>$environmentDirectory.'/config/session.php']);
        $this->assertEquals('<?php return [\'param3\' => false];', $fileContents);

        $this->assertEquals(DeployerConfiguration::getUnixConfigFileMask(), substr(sprintf('%o', fileperms($environmentDirectory.'/config/app.php')), -3));

        $this->assertFileExists($environmentDirectory.'/metadata/status.json');
        $statusContents = json_decode(file_get_contents($environmentDirectory.'/metadata/status.json'), true);
        $this->assertNotNull($statusContents);
        $this->assertInternalType('array', $statusContents);
        $this->assertArrayHasKey('deploymentEnvironments', $statusContents);
        $this->assertArrayHasKey('deploymentLog', $statusContents);
        $this->assertInternalType('array', $statusContents['deploymentLog']);
        $this->assertCount(2, $statusContents['deploymentLog']);
        $this->assertInternalType('array', $statusContents['deploymentLog'][1]);
        $this->assertTrue(isset($statusContents['deploymentLog'][1]['components']));
        $this->assertTrue(isset($statusContents['deploymentLog'][1]['environment']));
        $this->assertCount(1, $statusContents['deploymentLog'][1]['components']);
        $this->assertCount(2, $statusContents['deploymentLog'][1]['environment']);
        $this->assertContains('config', $statusContents['deploymentLog'][1]['components']);

        $this->assertTrue(isset($statusContents['deploymentEnvironments']['blue']));
    }

    public function testConfigurationOperationNoTemplates()
    {
        $params = $this->makeValidDeploymentConfig();
        unset($params['params']['configTemplates']);

        $response = $this->runDeploymentRequest($params, '/configure');
        $this->assertEquals(400, $response->getStatusCode());

        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('http', $responseBody->type);
        $this->assertContains('configTemplates not found in the request', $responseBody->error);
    }

    public function testConfigurationOperationInvalidTemplateNames()
    {
        $params = $this->makeValidDeploymentConfig();
        $params['params']['configTemplates'] = [
            'something.sh' => ['template' => '', 'vars' => []]
        ];

        $response = $this->runDeploymentRequest($params, '/configure');
        $this->assertEquals(400, $response->getStatusCode());

        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('http', $responseBody->type);
        $this->assertContains('Invalid configuration template name', $responseBody->error);
    }

    public function testConfigurationOperationTemplateSourceNotFound()
    {
        $params = $this->makeValidDeploymentConfig();
        $params['params']['configTemplates'] = [
            'app.php' => ['vars' => []]
        ];

        $response = $this->runDeploymentRequest($params, '/configure');
        $this->assertEquals(400, $response->getStatusCode());

        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('http', $responseBody->type);
        $this->assertContains('template parameter is not found', $responseBody->error);
    }

    public function testConfigurationOperationTemplateVarsNotFound()
    {
        $params = $this->makeValidDeploymentConfig();
        $params['params']['configTemplates'] = [
            'app.php' => ['template' => '']
        ];

        $response = $this->runDeploymentRequest($params, '/configure');
        $this->assertEquals(400, $response->getStatusCode());

        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('http', $responseBody->type);
        $this->assertContains('vars parameter is not found', $responseBody->error);
    }

    public function testConfigurationOperationTemplateVarsNotArray()
    {
        $params = $this->makeValidDeploymentConfig();
        $params['params']['configTemplates'] = [
            'app.php' => ['template' => '', 'vars' => true]
        ];

        $response = $this->runDeploymentRequest($params, '/configure');
        $this->assertEquals(400, $response->getStatusCode());

        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('http', $responseBody->type);
        $this->assertContains('must be an array', $responseBody->error);
    }

    public function testConfigurationOperationTemplateNotString()
    {
        $params = $this->makeValidDeploymentConfig();
        $params['params']['configTemplates'] = [
            'app.php' => ['template' => true, 'vars' => []]
        ];

        $response = $this->runDeploymentRequest($params, '/configure');
        $this->assertEquals(400, $response->getStatusCode());

        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('http', $responseBody->type);
        $this->assertContains('must be a string', $responseBody->error);
    }

    public function testNotStringBuildTag()
    {
        $params = $this->makeValidDeploymentConfig();
        $params['params']['buildTag'] = 10;

        $response = $this->runDeploymentRequest($params, '/deploy');
        $this->assertEquals(400, $response->getStatusCode());

        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('http', $responseBody->type);
        $this->assertContains('must be a string', $responseBody->error);
    }

    public function testTooLongBuildTag()
    {
        $params = $this->makeValidDeploymentConfig();
        $params['params']['buildTag'] = str_repeat('x', 51);

        $response = $this->runDeploymentRequest($params, '/deploy');
        $this->assertEquals(400, $response->getStatusCode());

        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('http', $responseBody->type);
        $this->assertContains('must be a string', $responseBody->error);
    }
}