<?php namespace Tests\Functional;

use PhpDeployer\Ssh\Connection;
use PhpDeployer\Exceptions\BufferedOutput as BufferedOutputException;

class SshConnectionTest extends BaseCase
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
        $this->assertEquals('README.md', $result);
    }

    public function testRunSimpleWithVars()
    {
        $connection = $this->makeValidConnection();

        $result = $connection->runCommand('ls {{$path}}', 10, ['path'=>'/var/php-deployer/tests/fixtures/test-dir']);
        $this->assertEquals('README.md', $result);
    }

    public function testRunShortSleepCommand()
    {
        $connection = $this->makeValidConnection();

        $result = $connection->runCommand('/var/php-deployer/tests/fixtures/test-scripts/sleep-2-seconds.sh', 3);
        $this->assertEquals('done', $result);
    }

    public function testRunTimedOutCommand()
    {
        $connection = $this->makeValidConnection();

        try {
            $connection->runCommand('/var/php-deployer/tests/fixtures/test-scripts/sleep-5-seconds.sh', 1);
            $this->assertTrue(false, 'The command `sleep-5-seconds.sh` must time out');
        }
        catch (BufferedOutputException $ex) {
            $this->assertInstanceOf(BufferedOutputException::class, $ex);
            $this->assertEquals(124, $ex->getCode());
            $this->assertEquals('start', $ex->getStdOutBuffer());
            $this->assertEquals('Command timed out', $ex->getMessage());
        }
    }

    public function testRunLongButNotTimedOutCommand()
    {
        $connection = $this->makeValidConnection();

        $result = $connection->runCommand('/var/php-deployer/tests/fixtures/test-scripts/run-2-seconds-output-300ms.sh', 2);
        $this->assertEquals('1'.Connection::NL.'2'.Connection::NL.'3'.Connection::NL.'4'.Connection::NL.'5'.Connection::NL.'6'.Connection::NL.'7', $result);
    }

    public function testRunInvalidCommand()
    {
        $connection = $this->makeValidConnection();

        try {
            $connection->runCommand('this-command-doesnt-exist');
            $this->assertTrue(false, 'The invalid command `this-command-doesnt-exist` must fail');
        }
        catch (BufferedOutputException $ex) {
            $this->assertInstanceOf(BufferedOutputException::class, $ex);
            $this->assertEquals(127, $ex->getCode());
            $this->assertEmpty($ex->getStdOutBuffer());
            $this->assertContains('command not found', $ex->getMessage());
        }
    }

    public function testRunSyntaxErrorCommand()
    {
        $connection = $this->makeValidConnection();

        try {
            $connection->runCommand('ls ;;-l', 2);
            $this->assertTrue(false, 'The command with syntax error `ls ;;-l` must fail');
        }
        catch (BufferedOutputException $ex) {
            $this->assertInstanceOf(BufferedOutputException::class, $ex);
            $this->assertEquals(2, $ex->getCode());
            $this->assertEmpty($ex->getStdOutBuffer());
            $this->assertContains('syntax error', $ex->getMessage());
        }
    }

    public function testRunSyntaxErrorInShCommand()
    {
        $connection = $this->makeValidConnection();

        try {
            $connection->runCommand('/var/php-deployer/tests/fixtures/test-scripts/syntax-error.sh');
            $this->assertTrue(false, 'The command with syntax error `syntax-error.sh` must fail');
        }
        catch (BufferedOutputException $ex) {
            $this->assertInstanceOf(BufferedOutputException::class, $ex);
            $this->assertEquals(2, $ex->getCode());
            $this->assertEmpty($ex->getStdOutBuffer());
            $this->assertContains('syntax error', $ex->getMessage());
        }
    }

    public function testRunErrorCommandPrintedSomethingToStdOut()
    {
        $connection = $this->makeValidConnection();

        try {
            $connection->runCommand('/var/php-deployer/tests/fixtures/test-scripts/error-but-returning-to-stdio.sh');
            $this->assertTrue(false, 'The command `error-but-returning-to-stdio.sh` must fail');
        }
        catch (BufferedOutputException $ex) {
            $this->assertInstanceOf(BufferedOutputException::class, $ex);
            $this->assertEquals(1, $ex->getCode());
            $this->assertContains('Something', $ex->getStdOutBuffer());
            $this->assertContains('The command returned non-zero exit code', $ex->getMessage());
        }
    }

    public function testRunErrorCommandPrintedSomethingToStdErrAndStdIo()
    {
        $connection = $this->makeValidConnection();

        try {
            $connection->runCommand('/var/php-deployer/tests/fixtures/test-scripts/output-to-stderr-and-stdio.sh');
            $this->assertTrue(false, 'The command `output-to-stderr-and-stdio.sh` must fail');
        }
        catch (BufferedOutputException $ex) {
            $this->assertInstanceOf(BufferedOutputException::class, $ex);
            $this->assertEquals(1, $ex->getCode());
            $this->assertEquals('SomethngStdIo', $ex->getStdOutBuffer());
            $this->assertContains('SomethingStdErr', $ex->getMessage());
        }
    }

    public function testMasking()
    {
        $connection = $this->makeValidConnection();

        $connection->runCommand('ls /var/php-deployer/tests/fixtures/test-dir');
        $masked = $connection->maskCommand('secretString and passhpraseValue');
        $this->assertEquals('xxx and xxx', $masked);
    }

    public function testRunMultiCommandsNoError()
    {
        $connection = $this->makeValidConnection();

        $result = $connection->runMultipleCommands('echo 1; echo 2;'.PHP_EOL.'echo 3'); // OK to use PHP_EOL here as it's an input
        $this->assertEquals('$ echo 1; echo 2;'.Connection::NL.'1'.Connection::NL.'2'.Connection::NL.'$ echo 3'.Connection::NL.'3'.Connection::NL, $result);
    }

    public function testRunMultiCommandsWithVarsNoError()
    {
        $connection = $this->makeValidConnection();

        $result = $connection->runMultipleCommands('echo {{$num}}; echo {{$num}};'.PHP_EOL.'echo 3', 10, ['num'=>4]); // OK to use PHP_EOL here as it's an input
        $this->assertEquals('$ echo 4; echo 4;'.Connection::NL.'4'.Connection::NL.'4'.Connection::NL.'$ echo 3'.Connection::NL.'3'.Connection::NL, $result);
    }

    public function testRunMultiCommandsSyntaxErrorWithSanitizing()
    {
        $connection = $this->makeValidConnection();

        try {
            $result = $connection->runMultipleCommands('echo 1; echo 2;'.PHP_EOL.';;echo secretString');
            $this->assertTrue(false, 'The command with syntax error must fail');
        }
        catch (BufferedOutputException $ex) {
            $this->assertInstanceOf(BufferedOutputException::class, $ex);
            $this->assertContains('syntax error', $ex->getMessage());
            $this->assertEquals(2, $ex->getCode());
            $this->assertEquals('$ echo 1; echo 2;'.Connection::NL.'1'.Connection::NL.'2'.Connection::NL.'$ ;;echo xxx', $ex->getStdOutBuffer());
        }
    }

    public function testUpload()
    {
        $connection = $this->makeValidConnection();
        $remoteFilePath = '/var/www/'.microtime().'.tmp';
        $connection->upload(__DIR__.'/../fixtures/test-dir/README.md', $remoteFilePath);
        $result = $connection->runCommand('ls "'.$remoteFilePath.'"');
        $this->assertContains($remoteFilePath, $result);

        $result = $connection->runCommand('cat "'.$remoteFilePath.'"');
        $this->assertContains('command via SSH', $result);
    }

    /**
     * @expectedException        Exception
     * @expectedExceptionMessage Error uploading
     */
    public function testUploadError()
    {
        $connection = $this->makeValidConnection();
        $remoteFilePath = '/var/www/'.microtime().'.tmp';
        $connection->upload(__DIR__.'/../fixtures/test-dir/not-a-file', $remoteFilePath);
    }
}