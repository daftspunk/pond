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

    public function testNewDeploymentPartialProjectNoErrorsNoConfig()
    {
        $params = $this->makeValidDeploymentConfig();
        $params['params']['localProjectPath'] = __DIR__.'/../fixtures/partial-test-project';

        $pondRoot = DeployerConfiguration::POND_ROOT;

        $environmentDirectory = $pondRoot.'/'.
            $params['params']['projectDirectoryName'].'/'.
            $params['params']['environmentDirectoryName'];

        $this->assertDirectoryNotExists($environmentDirectory);

        $response = $this->runDeploymentRequest($params);

        $this->assertEquals(200, $response->getStatusCode());
        $responseBody = json_decode((string)$response->getBody());
        // $this->assertNotNull($responseBody); Should not be null, should return the actual log of commands and responses

        $this->assertDirectoryExists($environmentDirectory.'/config');
        $this->assertDirectoryExists($environmentDirectory.'/blue');
        $this->assertDirectoryExists($environmentDirectory.'/green');
        $this->assertDirectoryExists($environmentDirectory.'/metadata');
        $this->assertDirectoryExists($environmentDirectory.'/storage');
        $this->assertDirectoryExists($environmentDirectory.'/storage');
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

        return $params;
    }

    /**
     * @depends testNewDeploymentPartialProjectNoErrorsNoConfig
     */
    public function testConfigurationOperation($params)
    {
        // TODO: supply templates to $params, run tests with errros

        $response = $this->runDeploymentRequest($params, '/configure');

        $this->assertEquals(200, $response->getStatusCode());

        // Test no templates
        // Test invalid template names
        // Test 'template' parameter not found
        // Test 'var' parameter not found or is not an array
        // Test template is not string
    }
}