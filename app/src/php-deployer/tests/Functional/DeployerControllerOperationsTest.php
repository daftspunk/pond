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
        $this->assertDirectoryExists($environmentDirectory.'/pond-tmp');

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

        $this->assertEquals($params['params']['permissions']['config'], substr(sprintf('%o', fileperms($environmentDirectory.'/config/app.php')), -3));
        $this->assertEquals($params['params']['permissions']['file'], substr(sprintf('%o', fileperms($environmentDirectory.'/blue/index.php')), -3));
        $this->assertEquals($params['params']['permissions']['directory'], substr(sprintf('%o', fileperms($environmentDirectory.'/blue/plugins/october')), -3));
        $this->assertEquals($params['params']['permissions']['directory'], substr(sprintf('%o', fileperms($environmentDirectory.'/config')), -3));

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
        $this->assertTrue(isset($statusContents['deploymentLog'][0]['type']));
        $this->assertInternalType('array', $statusContents['deploymentLog'][0]['components']);
        $this->assertEquals('first-build', $statusContents['deploymentEnvironments']['green']['buildTag']);
        $this->assertEquals('success', $statusContents['deploymentLog'][0]['status']);
        $this->assertEquals('deploy', $statusContents['deploymentLog'][0]['type']);

        $this->assertContains('core', $statusContents['deploymentLog'][0]['components']);
        $this->assertContains('media', $statusContents['deploymentLog'][0]['components']);
        $this->assertContains('uploads', $statusContents['deploymentLog'][0]['components']);
        $this->assertContains('plugins', $statusContents['deploymentLog'][0]['components']);
        $this->assertContains('themes', $statusContents['deploymentLog'][0]['components']);
        $this->assertContains('config', $statusContents['deploymentLog'][0]['components']);

        $this->assertEmpty(array_diff(scandir($environmentDirectory.'/pond-tmp'), ['.', '..']));

        return [
            'params'=>$params, 
            'environmentDirectory'=>$environmentDirectory
        ];
    }

    public function testNewDeploymentNoDatabaseExist()
    {
        $params = $this->makeValidDeploymentConfig();
        $params['params']['localProjectPath'] = __DIR__.'/../fixtures/partial-test-project';
        $params['params']['buildTag'] = 'first-build';
        $params['params']['databaseInit'] = $this->makeDatabaseInitParams();
        $params['params']['databaseInit']['connection']['database'] = 'no-database';

        $pondRoot = DeployerConfiguration::POND_ROOT;

        $environmentDirectory = $pondRoot.'/'.
            $params['params']['projectDirectoryName'].'/'.
            $params['params']['environmentDirectoryName'];

        $this->assertDirectoryNotExists($environmentDirectory);
        $response = $this->runDeploymentRequest($params);
        // print_r((string)$response->getBody());

        $this->assertEquals(500, $response->getStatusCode());
        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('command', $responseBody->type);
        $this->assertContains('Unknown database ', $responseBody->error);
    }

    
    // Test database is not empty
    // Test the temp directory is empty

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
        $this->assertEquals($params['params']['permissions']['config'], substr(sprintf('%o', fileperms($environmentDirectory.'/config/app.php')), -3));

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
        $this->assertTrue(isset($statusContents['deploymentLog'][1]['type']));
        $this->assertCount(1, $statusContents['deploymentLog'][1]['components']);
        $this->assertCount(2, $statusContents['deploymentLog'][1]['environment']);
        $this->assertContains('config', $statusContents['deploymentLog'][1]['components']);
        $this->assertEquals('config', $statusContents['deploymentLog'][1]['type']);

        $this->assertTrue(isset($statusContents['deploymentEnvironments']['blue']));
        $this->assertEmpty(array_diff(scandir($environmentDirectory.'/pond-tmp'), ['.', '..']));
    }

    /**
     * @depends testNewDeploymentPartialProjectNoErrors
     */
    public function testUpdateDeployment($input)
    {
        extract($input);
 
        $params['params']['update'] = true;
        $params['params']['localProjectPath'] = __DIR__.'/../fixtures/partial-test-update-project';
        $params['params']['updateComponents'] = [
            'core' => true,
            'plugins' => ['october/demo2'],
            'themes' => true
        ];

        $response = $this->runDeploymentRequest($params);
        $this->assertEquals(200, $response->getStatusCode());

        $this->assertTrue(is_link($environmentDirectory.'/current'));
        $this->assertEquals($environmentDirectory.'/green', readlink($environmentDirectory.'/current'));

        // Green is active, the updated files should be in blue

        $this->assertFileExists($environmentDirectory.'/blue/plugins/october/demo2/Plugin.php');
        $this->assertFileExists($environmentDirectory.'/blue/themes/demo2/theme.yaml');
        $this->assertEquals($params['params']['permissions']['file'], substr(sprintf('%o', fileperms($environmentDirectory.'/blue/plugins/october/demo2/Plugin.php')), -3));
        $this->assertEquals($params['params']['permissions']['directory'], substr(sprintf('%o', fileperms($environmentDirectory.'/blue/plugins/october/demo2')), -3));

        // And there should be no updated files in green

        $this->assertFileNotExists($environmentDirectory.'/green/plugins/october/demo2/Plugin.php');
        $this->assertFileNotExists($environmentDirectory.'/green/themes/demo2/theme.yaml');
    }

    public function testUpdateNoProjectDirectory()
    {
        $params = $this->makeValidDeploymentConfig(true);

        $response = $this->runDeploymentRequest($params, '/deploy');
        $this->assertEquals(500, $response->getStatusCode());

        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('general', $responseBody->type);
        $this->assertContains('The project directory does not exist', $responseBody->error);
    }

    public function testUpdateNoEnvironmentDirectory()
    {
        $params = $this->makeValidDeploymentConfig(true);

        $pondRoot = DeployerConfiguration::POND_ROOT;
        $projectDirectory = $pondRoot.'/'.$params['params']['projectDirectoryName'];

        $this->assertDirectoryNotExists($projectDirectory);
        $this->makeDir($projectDirectory);

        $response = $this->runDeploymentRequest($params, '/deploy');
        $this->assertEquals(500, $response->getStatusCode());

        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('general', $responseBody->type);
        $this->assertContains('project environment directory', $responseBody->error);
    }

    public function testUpdateNoDeploymentEnvironmentDirectory()
    {
        $params = $this->makeValidDeploymentConfig(true);

        $pondRoot = DeployerConfiguration::POND_ROOT;
        $projectDirectory = $pondRoot.'/'.$params['params']['projectDirectoryName'];

        $this->assertDirectoryNotExists($projectDirectory);
        $this->makeDir($projectDirectory);

        $environmentDirectory = $projectDirectory.'/'.$params['params']['environmentDirectoryName'];
        $this->makeDir($environmentDirectory);

        $response = $this->runDeploymentRequest($params, '/deploy');
        $this->assertEquals(500, $response->getStatusCode());

        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('general', $responseBody->type);
        $this->assertContains('The deployment environment directory does not exist', $responseBody->error);

        $blueDirectory = $environmentDirectory.'/blue';
        $this->makeDir($blueDirectory);

        $response = $this->runDeploymentRequest($params, '/deploy');
        $this->assertEquals(500, $response->getStatusCode());

        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('general', $responseBody->type);
        $this->assertContains('The deployment environment directory does not exist', $responseBody->error);
    }

    public function testUpdateNoCurrentLink()
    {
        $params = $this->makeValidDeploymentConfig(true);

        $pondRoot = DeployerConfiguration::POND_ROOT;
        $projectDirectory = $pondRoot.'/'.$params['params']['projectDirectoryName'];

        $this->assertDirectoryNotExists($projectDirectory);
        $this->makeDir($projectDirectory);

        $environmentDirectory = $projectDirectory.'/'.$params['params']['environmentDirectoryName'];
        $this->makeDir($environmentDirectory);

        $blueDirectory = $environmentDirectory.'/blue';
        $this->makeDir($blueDirectory);

        $greenDirectory = $environmentDirectory.'/green';
        $this->makeDir($greenDirectory);

        $response = $this->runDeploymentRequest($params, '/deploy');
        $this->assertEquals(500, $response->getStatusCode());

        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('general', $responseBody->type);
        $this->assertContains('The "current" symbolic link does not exist', $responseBody->error);
    }

    public function testUpdateCurrentInvalidTarget()
    {
        $params = $this->makeValidDeploymentConfig(true);

        $pondRoot = DeployerConfiguration::POND_ROOT;
        $projectDirectory = $pondRoot.'/'.$params['params']['projectDirectoryName'];

        $this->assertDirectoryNotExists($projectDirectory);
        $this->makeDir($projectDirectory);

        $environmentDirectory = $projectDirectory.'/'.$params['params']['environmentDirectoryName'];
        $this->makeDir($environmentDirectory);

        $blueDirectory = $environmentDirectory.'/blue';
        $this->makeDir($blueDirectory);

        $greenDirectory = $environmentDirectory.'/green';
        $this->makeDir($greenDirectory);

        $currentPath = $environmentDirectory.'/current';
        symlink('/var/php-deployer', $currentPath);

        $response = $this->runDeploymentRequest($params, '/deploy');
        $this->assertEquals(500, $response->getStatusCode());

        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('general', $responseBody->type);
        $this->assertContains('symbolic link has invalid target', $responseBody->error);
    }

    /**
     * @depends testNewDeploymentPartialProjectNoErrors
     */
    public function testSwap($input)
    {
        extract($input);

        $params['params']['activate'] = 'blue';

        $response = $this->runDeploymentRequest($params, '/swap');
        // print_r((string)$response->getBody());
        $this->assertEquals(200, $response->getStatusCode());
        $this->assertEquals($environmentDirectory.'/blue', readlink($environmentDirectory.'/current'));

        $this->assertFileExists($environmentDirectory.'/metadata/status.json');
        $statusContents = json_decode(file_get_contents($environmentDirectory.'/metadata/status.json'), true);
        $this->assertNotNull($statusContents);
        $this->assertInternalType('array', $statusContents);
        $this->assertArrayHasKey('deploymentEnvironments', $statusContents);
        $this->assertArrayHasKey('deploymentLog', $statusContents);
        $this->assertInternalType('array', $statusContents['deploymentLog']);
        $this->assertCount(4, $statusContents['deploymentLog']);
        $this->assertInternalType('array', $statusContents['deploymentLog'][3]);
        $this->assertTrue(isset($statusContents['deploymentLog'][3]['components']));
        $this->assertTrue(isset($statusContents['deploymentLog'][3]['environment']));
        $this->assertTrue(isset($statusContents['deploymentLog'][3]['type']));
        $this->assertEquals('swap', $statusContents['deploymentLog'][3]['type']);
        $this->assertEquals('success', $statusContents['deploymentLog'][3]['status']);

        return $input;
    }

    public function testSwapNoEnvironmentDirectory()
    {
        $params = $this->makeValidDeploymentConfig(true);
        $params['params']['projectDirectoryName'] = uniqid();
        $params['params']['activate'] = 'blue';

        $pondRoot = DeployerConfiguration::POND_ROOT;
        $projectDirectory = $pondRoot.'/'.$params['params']['projectDirectoryName'];
        $this->assertDirectoryNotExists($projectDirectory);

        $response = $this->runDeploymentRequest($params, '/swap');
        $this->assertEquals(400, $response->getStatusCode());
        $responseBody = json_decode((string)$response->getBody());
        $this->assertEquals('http', $responseBody->type);
        $this->assertContains('e environment directory is not found on the server', $responseBody->error);
    }

    /**
     * @depends testSwap
     */
    public function testSwapAlreadyActive($input)
    {
        extract($input);

        $params['params']['activate'] = 'blue';

        $response = $this->runDeploymentRequest($params, '/swap');
        // print_r((string)$response->getBody());
        $this->assertEquals(400, $response->getStatusCode());
        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('http', $responseBody->type);
        $this->assertContains('already active', $responseBody->error);

        $this->assertFileExists($environmentDirectory.'/metadata/status.json');
        $statusContents = json_decode(file_get_contents($environmentDirectory.'/metadata/status.json'), true);
        $this->assertNotNull($statusContents);
        $this->assertInternalType('array', $statusContents);
        $this->assertArrayHasKey('deploymentEnvironments', $statusContents);
        $this->assertArrayHasKey('deploymentLog', $statusContents);
        $this->assertInternalType('array', $statusContents['deploymentLog']);
        $this->assertCount(5, $statusContents['deploymentLog']);
        $this->assertInternalType('array', $statusContents['deploymentLog'][4]);
        $this->assertTrue(isset($statusContents['deploymentLog'][4]['type']));
        $this->assertEquals('swap', $statusContents['deploymentLog'][4]['type']);
        $this->assertEquals('fail', $statusContents['deploymentLog'][4]['status']);
    }

    public function testGetStatusNoEnvironmentDirectory()
    {
        $params = $this->makeValidDeploymentConfig(true);
        $params['params']['projectDirectoryName'] = uniqid();

        $pondRoot = DeployerConfiguration::POND_ROOT;
        $projectDirectory = $pondRoot.'/'.$params['params']['projectDirectoryName'];
        $this->assertDirectoryNotExists($projectDirectory);

        $response = $this->runDeploymentRequest($params, '/status');

        $this->assertEquals(400, $response->getStatusCode());
        $responseBody = json_decode((string)$response->getBody());
        $this->assertEquals('http', $responseBody->type);
        $this->assertContains('environment directory is not found', $responseBody->error);
    }

    public function testGetStatusNoStatusFileOrEmptyOrInvalid()
    {
        $params = $this->makeValidDeploymentConfig(true);
        $params['params']['projectDirectoryName'] = uniqid();

        $pondRoot = DeployerConfiguration::POND_ROOT;
        $projectDirectory = $pondRoot.'/'.$params['params']['projectDirectoryName'];

        $this->assertDirectoryNotExists($projectDirectory);
        $this->makeDir($projectDirectory);

        $environmentDirectory = $projectDirectory.'/'.$params['params']['environmentDirectoryName'];
        $this->makeDir($environmentDirectory);

        $response = $this->runDeploymentRequest($params, '/status');

        $this->assertEquals(400, $response->getStatusCode());
        $responseBody = json_decode((string)$response->getBody());
        $this->assertEquals('http', $responseBody->type);
        $this->assertContains('environment status file is not found', $responseBody->error);

        $filePath = $environmentDirectory.'/metadata/status.json';
        $this->makeDir(dirname($filePath));
        $this->assertDirectoryExists(dirname($filePath));

        file_put_contents($filePath, '');

        $response = $this->runDeploymentRequest($params, '/status');
        $this->assertEquals(500, $response->getStatusCode());
        $responseBody = json_decode((string)$response->getBody());
        $this->assertEquals('general', $responseBody->type);
        $this->assertContains('is empty', $responseBody->error);

        file_put_contents($filePath, '@');

        $response = $this->runDeploymentRequest($params, '/status');
        $this->assertEquals(500, $response->getStatusCode());
        $responseBody = json_decode((string)$response->getBody());
        $this->assertEquals('general', $responseBody->type);
        $this->assertContains('Error parsing', $responseBody->error);
    }

    /**
     * @depends testSwap
     */
    public function testGetStatus($input)
    {
        extract($input);

        $this->assertEquals($environmentDirectory.'/blue', readlink($environmentDirectory.'/current'));

        $response = $this->runDeploymentRequest($params, '/status');
        $statusObject = json_decode((string)$response->getBody(), true);
        $this->assertEquals(200, $response->getStatusCode());

        $this->assertNotNull($statusObject);
        $this->assertArrayHasKey('status', $statusObject);
        $this->assertCount(5, $statusObject['status']['deploymentLog']);
        $this->assertArrayHasKey('active', $statusObject);
        $this->assertEquals('blue', $statusObject['active']);
    }
}