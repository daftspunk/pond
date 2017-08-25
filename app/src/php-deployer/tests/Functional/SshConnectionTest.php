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

    public function testRunShortSleepCommand()
    {
        $connection = $this->makeValidConnection();

        $result = $connection->runCommand('/var/php-deployer/tests/fixtures/test-scripts/sleep-2-seconds.sh', 3);
        $this->assertEquals('done', trim($result));
    }

    /**
     * @expectedException        Exception
     * @expectedExceptionMessage Command timed out
     */
    public function testRunTimedOutCommand()
    {
        $connection = $this->makeValidConnection();

        $result = $connection->runCommand('/var/php-deployer/tests/fixtures/test-scripts/sleep-5-seconds.sh', 1);
        $this->assertEquals('done', trim($result));
    }

    public function testRunLongButNotTimedOutCommand()
    {
        $connection = $this->makeValidConnection();

        $result = $connection->runCommand('/var/php-deployer/tests/fixtures/test-scripts/run-2-seconds-output-500ms.sh', 1);
        $this->assertEquals('1'.PHP_EOL.'2'.PHP_EOL.'3'.PHP_EOL.'4', trim($result));
    }

    /**
     * @expectedException        Exception
     * @expectedExceptionMessage command not found
     */
    public function testRunInvalidCommand()
    {
        $connection = $this->makeValidConnection();

        $result = $connection->runCommand('this-command-doesnt-exist');
    }

    /**
     * @expectedException        PhpDeployer\ErrorOutputException
     * @expectedExceptionMessage Something
     * @expectedExceptionCode    1
     */
    public function testRunErrorCommandPrintedSomethingToStdOut()
    {
        $connection = $this->makeValidConnection();

        $result = $connection->runCommand('/var/php-deployer/tests/fixtures/test-scripts/error-but-returning-to-stdio.sh');
    }

    // Test case when a script writes something to stdoout

    // Test masking

    // Test timeout
}