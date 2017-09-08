<?php namespace Tests\Functional;

class DeployerControllerValidationTest extends BaseCase
{
    public function testDeployNotJson()
    {
        $response = $this->runApp('POST', '/deploy');
    
        $this->assertEquals(400, $response->getStatusCode());
        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('http', $responseBody->type);
        $this->assertEquals('JSON expected', $responseBody->error);
    }

    public function testDeployNoCommonArguments()
    {
        $response = $this->runDeploymentRequest([]);

        $this->assertEquals(400, $response->getStatusCode());
        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('http', $responseBody->type);
        $this->assertContains('privateKeyPath', $responseBody->error);
    }

    public function testDeployInvalidIp()
    {
        $params = $this->makeValidDeploymentConfig();
        $params['ip'] = 'a.b.c.d';

        $response = $this->runDeploymentRequest($params);

        $this->assertEquals(400, $response->getStatusCode());
        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('http', $responseBody->type);
        $this->assertEquals('Invalid IP address', $responseBody->error);
    }

    public function testDeployNoUser()
    {
        $params = $this->makeValidDeploymentConfig();
        $params['user'] = '';

        $response = $this->runDeploymentRequest($params);

        $this->assertEquals(400, $response->getStatusCode());
        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('http', $responseBody->type);
        $this->assertEquals('Invalid user name', $responseBody->error);
    }

    public function testDeployNoParams()
    {
        $params = $this->makeValidDeploymentConfig();
        unset($params['params']);

        $response = $this->runDeploymentRequest($params);

        $this->assertEquals(400, $response->getStatusCode());
        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('http', $responseBody->type);
        $this->assertContains('params not found in the request', $responseBody->error);
    }

    public function testDeployParamsNotArray()
    {
        $params = $this->makeValidDeploymentConfig();
        $params['params'] = 'test';

        $response = $this->runDeploymentRequest($params);

        $this->assertEquals(400, $response->getStatusCode());
        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('http', $responseBody->type);
        $this->assertContains('should be an array', $responseBody->error);
    }

    public function testDeployNoUpdateFlag()
    {
        $params = $this->makeValidDeploymentConfig();
        unset($params['params']['update']);

        $response = $this->runDeploymentRequest($params);

        $this->assertEquals(400, $response->getStatusCode());
        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('http', $responseBody->type);
        $this->assertContains('parameter update not found', $responseBody->error);
    }

    public function testDeployInvalidUpdateFlag()
    {
        $params = $this->makeValidDeploymentConfig();
        $params['params']['update'] = 'invalid';

        $response = $this->runDeploymentRequest($params);

        $this->assertEquals(400, $response->getStatusCode());
        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('http', $responseBody->type);
        $this->assertEquals('The update parameter should be of boolean type', $responseBody->error);
    }

    public function testDeployInvalidProjectDirectoryName()
    {
        $params = $this->makeValidDeploymentConfig();
        $params['params']['projectDirectoryName'] = 'some/thing';

        $response = $this->runDeploymentRequest($params);

        $this->assertEquals(400, $response->getStatusCode());
        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('http', $responseBody->type);
        $this->assertEquals('The project directory name can contain only alphanumeric, dash and underscore characters', $responseBody->error);
    }
}