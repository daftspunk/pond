<?php namespace Tests\Functional;

use PhpDeployer\Operations\Deployment as DeploymentOperation;
use Exception;

class DeployerControllerOperationTest extends BaseCase
{
    public function testNewDeploymentEnviromentDirectoryExists()
    {
        $params = $this->makeValidDeploymentConfig();
        $pondRoot = DeploymentOperation::POND_ROOT;

        $environmentDirectory = $pondRoot.'/'.
            $params['projectDirectoryName'].'/'.
            $params['environmentDirectoryName'];

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

    public function testInitDirectories()
    {
        // initDirectories 
    }

    public function testNewDeploymentNoErrors()
    {
//         $params = $this->makeValidDeploymentConfig();

//         $response = $this->runApp('POST', '/deploy', function($request) use ($params) {
//             $request->withHeader('Content-Type', 'application/json');
//             $request->getBody()->write(json_encode($params));
//         });
// print_r((string)$response->getBody());
//         $this->assertEquals(200, $response->getStatusCode());
        // $responseBody = json_decode((string)$response->getBody());
        // $this->assertNotNull($responseBody);
        // $this->assertEquals('http', $responseBody->type);
        // $this->assertContains($param, $responseBody->error);
    }


}