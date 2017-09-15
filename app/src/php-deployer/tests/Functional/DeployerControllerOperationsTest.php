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

        return [
            'params'=>$params, 
            'environmentDirectory'=>$environmentDirectory
        ];
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
}