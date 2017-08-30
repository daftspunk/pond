<?php

namespace Tests\Functional;

class DeployerControllerTest extends BaseTestCase
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
        $response = $this->runApp('POST', '/deploy', function($request) {
            $request->withHeader('Content-Type', 'application/json');
            $data = [];
            $request->getBody()->write(json_encode($data));
        });

        $this->assertEquals(400, $response->getStatusCode());
        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('http', $responseBody->type);
        $this->assertContains('privateKeyPath', $responseBody->error);
    }

    public function testDeployInvalidIp()
    {
        $response = $this->runApp('POST', '/deploy', function($request) {
            $request->withHeader('Content-Type', 'application/json');
            $data = [
                'privateKeyPath' => 'something',
                'publicKeyPath' => 'something',
                'ip' => 'a.b.c.d',
                'user' => 'some'
            ];
            $request->getBody()->write(json_encode($data));
        });

        $this->assertEquals(400, $response->getStatusCode());
        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('http', $responseBody->type);
        $this->assertEquals('Invalid IP address', $responseBody->error);
    }

    public function testDeployNoUser()
    {
        $response = $this->runApp('POST', '/deploy', function($request) {
            $request->withHeader('Content-Type', 'application/json');
            $data = [
                'privateKeyPath' => 'something',
                'publicKeyPath' => 'something',
                'ip' => '127.0.0.1',
                'user' => ''
            ];
            $request->getBody()->write(json_encode($data));
        });

        $this->assertEquals(400, $response->getStatusCode());
        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('http', $responseBody->type);
        $this->assertEquals('Invalid user name', $responseBody->error);
    }

    public function testDeployNoUpdateFlag()
    {
        $response = $this->runApp('POST', '/deploy', function($request) {
            $request->withHeader('Content-Type', 'application/json');
            $data = [
                'privateKeyPath' => 'something',
                'publicKeyPath' => 'something',
                'ip' => '127.0.0.1',
                'user' => 'deploy'
            ];
            $request->getBody()->write(json_encode($data));
        });

        $this->assertEquals(400, $response->getStatusCode());
        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('http', $responseBody->type);
        $this->assertContains('Argument update not found', $responseBody->error);
    }

    public function testDeployInvalidUpdateFlag()
    {
        $response = $this->runApp('POST', '/deploy', function($request) {
            $request->withHeader('Content-Type', 'application/json');
            $data = [
                'privateKeyPath' => 'something',
                'publicKeyPath' => 'something',
                'ip' => '127.0.0.1',
                'user' => 'deploy',
                'update' => 'invalid',
                'projectDirectoryName' => 'something',
                'environmentDirectoryName' => 'production'
            ];
            $request->getBody()->write(json_encode($data));
        });

        $this->assertEquals(400, $response->getStatusCode());
        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('http', $responseBody->type);
        $this->assertEquals('The update parameter should be of boolean type', $responseBody->error);
    }

    public function testDeployInvalidProjectDirectoryName()
    {
        $response = $this->runApp('POST', '/deploy', function($request) {
            $request->withHeader('Content-Type', 'application/json');
            $data = [
                'privateKeyPath' => 'something',
                'publicKeyPath' => 'something',
                'ip' => '127.0.0.1',
                'user' => 'deploy',
                'update' => true,
                'projectDirectoryName' => 'some/thing',
                'environmentDirectoryName' => 'production'
            ];

            $request->getBody()->write(json_encode($data));
        });

        $this->assertEquals(400, $response->getStatusCode());
        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('http', $responseBody->type);
        $this->assertEquals('The project directory name can contain only alphanumeric, dash and underscore characters', $responseBody->error);
    }

    public function testEmptyValues()
    {
        $allParams = [
            'privateKeyPath' => 'something',
            'publicKeyPath' => 'something',
            'ip' => '127.0.0.1',
            'user' => 'deploy',
            'update' => true,
            'projectDirectoryName' => 'something',
            'environmentDirectoryName' => 'production'
        ];

        foreach ($allParams as $param=>$value) {
            $params = $allParams;

            unset($params[$param]);

            $response = $this->runApp('POST', '/deploy', function($request) use ($params) {
                $request->withHeader('Content-Type', 'application/json');
                $request->getBody()->write(json_encode($params));
            });

            $this->assertEquals(400, $response->getStatusCode());
            $responseBody = json_decode((string)$response->getBody());
            $this->assertNotNull($responseBody);
            $this->assertEquals('http', $responseBody->type);
            $this->assertContains($param, $responseBody->error);
        }
    }
}