<?php namespace Tests\Functional;

use PhpDeployer\Ssh\Connection;
use PhpDeployer\Exceptions\BufferedOutput as BufferedOutputException;
use Exception;

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

        $log = [];
        $connection->setLogCallable(function($string) use (&$log) {
            $log[] = $string;
        });

        $result = $connection->runCommand('ls /var/php-deployer/tests/fixtures/test-dir');

        $this->assertEquals('README.md', $result);
        $this->assertCount(2, $log);
        $this->assertEquals('$ ls /var/php-deployer/tests/fixtures/test-dir', $log[0]);
        $this->assertEquals('README.md', $log[1]);

        $logArray = $connection->getLogAsArray();
        $this->assertCount(2, $logArray);
        $this->assertEquals('$ ls /var/php-deployer/tests/fixtures/test-dir', $logArray[0]);
        $this->assertEquals('README.md', $logArray[1]);
    }

    public function testRunSimpleWithVars()
    {
        $connection = $this->makeValidConnection();

        $result = $connection->runCommand('ls {{$path}}', 10, ['path'=>'/var/php-deployer/tests/fixtures/test-dir']);
        $this->assertEquals('README.md', $result);

        $logArray = $connection->getLogAsArray();
        $this->assertCount(2, $logArray);
        $this->assertEquals('$ ls /var/php-deployer/tests/fixtures/test-dir', $logArray[0]);
        $this->assertEquals('README.md', $logArray[1]);
    }

    public function testRunSimpleMasking()
    {
        $connection = $this->makeValidConnection();

        $result = $connection->runCommand('echo "passhpraseValue"');
        $this->assertEquals('xxx', $result);

        $logArray = $connection->getLogAsArray();
        $this->assertCount(2, $logArray);
        $this->assertEquals('$ echo "xxx"', $logArray[0]);
        $this->assertEquals('xxx', $logArray[1]);
    }

    public function testRunSimpleWithVarsMasking()
    {
        $connection = $this->makeValidConnection();

        $result = $connection->runCommand('echo "{{$value}}"', 10, ['value'=>'passhpraseValue']);
        $this->assertEquals('xxx', $result);

        $logArray = $connection->getLogAsArray();
        $this->assertCount(2, $logArray);
        $this->assertEquals('$ echo "xxx"', $logArray[0]);
        $this->assertEquals('xxx', $logArray[1]);
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

            $logArray = $connection->getLogAsArray();
            $this->assertCount(2, $logArray);
            $this->assertContains('command not found', $logArray[1]);
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

            $logArray = $connection->getLogAsArray();
            $this->assertCount(2, $logArray);
            $this->assertContains('syntax error', $logArray[1]);
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

        $logArray = $connection->getLogAsArray();

        $this->assertCount(4, $logArray);
        $this->assertEquals('$ echo 1; echo 2;', $logArray[0]);
        $this->assertEquals('1'.Connection::NL.'2', $logArray[1]);
        $this->assertEquals('$ echo 3', $logArray[2]);
        $this->assertEquals('3', $logArray[3]);
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

            $logArray = $connection->getLogAsArray();

            $this->assertCount(4, $logArray);
            $this->assertEquals('$ echo 1; echo 2;', $logArray[0]);
            $this->assertEquals('1'.Connection::NL.'2', $logArray[1]);
            $this->assertEquals('$ ;;echo xxx', $logArray[2]);
            $this->assertContains('syntax error', $logArray[3]);
        }
    }

    public function testUpload()
    {
        $connection = $this->makeValidConnection();
        $remoteFilePath = '/var/www/'.microtime().'.tmp';
        $connection->upload(__DIR__.'/../fixtures/test-dir/README.md', $remoteFilePath, 'log file');

        $logArray = $connection->getLogAsArray();
        $this->assertCount(1, $logArray);
        $this->assertEquals('Uploading log file...', $logArray[0]);

        $result = $connection->runCommand('ls "'.$remoteFilePath.'"');
        $this->assertContains($remoteFilePath, $result);

        $result = $connection->runCommand('cat "'.$remoteFilePath.'"');
        $this->assertContains('command via SSH', $result);
    }

    public function testUploadFromString()
    {
        $commandConnection = $this->makeValidConnection();
        $scpConnection = $this->makeValidConnection();
        $contents = 'Test contents';
        $remoteFilePath = '/var/www/'.microtime().'.tmp';

        $scpConnection->uploadFromString($commandConnection, $contents, $remoteFilePath, '/var/www/', '664', 'test file');
        $this->assertFileExists($remoteFilePath);
        $this->assertEquals('664', substr(sprintf('%o', fileperms($remoteFilePath)), -3));
        $this->assertStringEqualsFile($remoteFilePath, $contents);
    }

    public function testUploadError()
    {
        $connection = $this->makeValidConnection();
        $remoteFilePath = '/var/www/'.microtime().'.tmp';

        try {
            $connection->upload(__DIR__.'/../fixtures/test-dir/not-a-file', $remoteFilePath, 'not a file');
            $this->assertTrue(false, 'Invalid upload must fail');
        }
        catch (Exception $ex) {
            $this->assertContains('Error uploading', $ex->getMessage());

            $logArray = $connection->getLogAsArray();
            $this->assertCount(2, $logArray);
            $this->assertEquals('Uploading not a file...', $logArray[0]);
            $this->assertEquals('Error uploading file to the server', $logArray[1]);
        }
    }

    public function testCompoundCommand()
    {
        $connection = $this->makeValidConnection();
        $params = [
            'path' => __DIR__.'/../fixtures/partial-test-project'
        ];

        $result = $connection->runCommand('if [ -d "{{$path}}" ]; then find "{{$path}}" -type f; fi', 120, $params);
        $this->assertContains('autoload.php', $result);
    }

    public function testGetClientIp()
    {
        $connection = $this->makeValidConnection();
        $this->assertEquals('127.0.0.1', $connection->getClientIp());
    }
}