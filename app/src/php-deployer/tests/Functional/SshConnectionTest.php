<?php namespace Tests\Functional;

use PhpDeployer\Connection;

class SshConnectionTest extends BaseTestCase
{
    public function testConnectToHost()
    {
        $connection = $this->makeValidConnection();

        $this->assertInstanceOf(Connection::class, $connection);
    }

    /**
     * @expectedException        Exception
     * @expectedExceptionMessage Unable to establish
     */
    public function testCannotConnect()
    {
        $config = self::getConfig('connection');

        new Connection('192.0.2.0', 
            $config['publicKey'], 
            $config['privateKey'], 
            $config['user'],
            $config['stringMask'], 
            1);
    }

    /**
     * @expectedException        Exception
     * @expectedExceptionMessage Cannot authenticate
     */
    public function testCannotAuthenticate()
    {
        $config = self::getConfig('connection');

        new Connection($config['host'], 
            $config['publicKey'], 
            $config['privateKey'],
            'invaliduser', 
            $config['stringMask']);
    }

    /**
     * @expectedException        Exception
     * @expectedExceptionMessage SSH key file not found
     */
    public function testPrivateKeyNotFound()
    {
        $config = self::getConfig('connection');

        new Connection($config['host'], 
            $config['publicKey'], 
            '/var/target-server-dev-environment/keys/id_rsa2', 
            $config['user'],
            $config['stringMask']);
    }

    /**
     * @expectedException        Exception
     * @expectedExceptionMessage SSH key file not found
     */
    public function testPublicKeyNotFound()
    {
        $config = self::getConfig('connection');

        $connection = new Connection($config['host'], 
            '/var/target-server-dev-environment/keys/id_rsa2.pub', 
            $config['privateKey'], 
            $config['user'], 
            $config['stringMask']);
    }

    public function testRunSimpleCommand()
    {
        $connection = $this->makeValidConnection();

        $result = $connection->runCommand('ls /var/php-deployer/tests/fixtures/test-dir');

        $this->assertEquals('README.md', trim($result));
    }

    // Test invalid command or other problem which would go to stderror

    // Test masking

    // Test timeout
}