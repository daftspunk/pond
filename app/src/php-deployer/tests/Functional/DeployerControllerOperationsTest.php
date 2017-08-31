<?php namespace Tests\Functional;

use PhpDeployer\Operations\Deployment as DeploymentOperation;

class DeployerControllerOperationTest extends BaseCase
{
    public function testNewDeployment()
    {
        $config = self::getConfig('connection');

        $params = [
            'privateKeyPath' => $config['privateKey'],
            'publicKeyPath' => $config['publicKey'],
            'ip' => $config['host'],
            'user' => $config['user'],
            'update' => false,
            'projectDirectoryName' => $this->generateUniqueProjectName(DeploymentOperation::POND_ROOT),
            'environmentDirectoryName' => 'production'
        ];

        $response = $this->runApp('POST', '/deploy', function($request) use ($params) {
            $request->withHeader('Content-Type', 'application/json');
            $request->getBody()->write(json_encode($params));
        });
print_r((string)$response->getBody());
        $this->assertEquals(200, $response->getStatusCode());
        // $responseBody = json_decode((string)$response->getBody());
        // $this->assertNotNull($responseBody);
        // $this->assertEquals('http', $responseBody->type);
        // $this->assertContains($param, $responseBody->error);

    }
}