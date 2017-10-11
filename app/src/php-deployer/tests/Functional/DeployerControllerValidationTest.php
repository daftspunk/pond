<?php namespace Tests\Functional;

class DeployerControllerValidationTest extends BaseCase
{
    // Detailed tests for operation parameters are
    // defined in RequestContainerTest.php

    public function testDeployNotJson()
    {
        $response = $this->runApp('POST', '/deploy');
    
        $this->assertEquals(400, $response->getStatusCode());
        $responseBody = json_decode((string)$response->getBody());
        $this->assertNotNull($responseBody);
        $this->assertEquals('http', $responseBody->type);
        $this->assertEquals('JSON expected', $responseBody->error);
    }
}