<?php namespace PhpDeployer;

use Exception;

class Connection
{
    const NL = "\n"; // Don't depend on the platform new line. The target servers are Unix-based and always use \n.

    private $session;
    private $stringMasks = [];
    private $termStr = '@COMMAND-FINISHED@';
    private $termCmd = '; echo "%s"';

    private $defaultTimeout;

    /**
     * @param $stringMasks array Array of strings to be replaced with xxx value in command logs and exception messages.
     */
    public function __construct($ip, $publicKeyPath, $privateKeyPath, $userName, array $stringMasks = [], $connectionTimeout = 10)
    {
        $this->setSocketTimeout($connectionTimeout);
        $this->session = @ssh2_connect($ip, 22, array('hostkey'=>'ssh-rsa'));
        $this->resetSocketTimeout();

        if ($this->session === false) {
            throw new Exception(sprintf('Unable to establish SSH connection with the server %s', $ip));
        }

        $this->validateKeyFile($publicKeyPath);
        $this->validateKeyFile($privateKeyPath);

        if (@ssh2_auth_pubkey_file($this->session, $userName, $publicKeyPath, $privateKeyPath) === false) {
            throw new Exception(sprintf('Cannot authenticate SSH connection to server %s', $ip));
        }

        $this->makeMasks($stringMasks);
    }

    /**
     * Executes a single command and returns its result.
     *
     * Throws BufferedOutputException or Exception in case of issues.
     * 
     * @param string $command Command to execute
     * @param int $timeout Timeout for executing the command
     * @return string Returns the stdout buffer
     */
    public function runCommand($command, $timeout = 10)
    {
        $command = rtrim($command, ';').$this->makeTermCommand();

        $stream = ssh2_exec($this->session, $command);

        if (!$stream) {
            throw new Exception('Error executing command');
        }

        $result = '';

        $stdOutStream = ssh2_fetch_stream($stream, SSH2_STREAM_STDIO);
        $stdErrStream = ssh2_fetch_stream($stream, SSH2_STREAM_STDERR);

        $timeStart = time();

        try {
            while (true) {
                $stdOutBuffer = fread($stdOutStream, 4096);
                $stdErrBuffer = fread($stdErrStream, 4096);
                $result .= $stdOutBuffer;

                if (strlen($stdErrBuffer)) {
                    $exitCode = $this->extractExitCode($result);

                    if (strpos($stdErrBuffer, 'syntax error') === false) {;
                        $result = $this->readUntilTerm($stdOutStream, $result);
                        $exitCode = $this->extractExitCode($result);
                    }
                    else {
                        if ($exitCode === 0) {
                            $exitCode = 2;
                        }
                    }

                    throw new BufferedOutputException(
                        $this->maskCommand($stdErrBuffer),
                        $exitCode,
                        $this->maskCommand($result)
                    );
                }

                if (strlen($stdOutBuffer)) {
                    // If the command returns any output during the execution,
                    // we don't consider it timing out. The timeout is always
                    // measured since the last time we heard anything from 
                    // the command.

                    $timeStart = time();
                }

                if (strpos($result, $this->termStr) !== false) {
                    break;
                }

                if ((time() - $timeStart) >= $timeout) {
                    throw new BufferedOutputException(
                        'Command timed out',
                        124,
                        $this->maskCommand($result)
                    );
                }
            }
        }
        finally {
            @fclose($stdOutStream);
            @fclose($stdErrStream);
            @fclose($stream);
        }

        $exitCode = $this->extractExitCode($result);
        if ($exitCode != 0) {
            throw new BufferedOutputException(
                'The command returned non-zero exit code',
                $exitCode,
                $this->maskCommand($result)
            );
        }

        return $this->maskCommand($result);
    }

    /**
     * Runs multiple commands separated with the newline character.
     * Commands should not be related bound to each other, e.g. there
     * should not be multi-line expressions, condition structures,
     * variable assignments, etc.
     *
     * The output will contain commands themselves and their output.
     * The operation will stop on first error and BufferedOutputException 
     * will be thrown. The stderr buffer won't get to the result
     * in this case and should be read from BufferedOutputException.
     * 
     * @param string $commandsStr Commands to execute
     * @param int $timeout Timeout for executing a single command.
     * @return string Returns the stdout buffer
     */
    public function runMultipleCommands(string $commandsStr, $timeout = 10)
    {
        $commandsStr = str_replace("\r\n", self::NL, $commandsStr);
        $commands = explode(self::NL, $commandsStr);

        $result = '';
        foreach ($commands as $command) {
            $command = trim($command);
            if (!strlen($command)) {
                continue;
            }

            $result .= '$ '.$this->maskCommand($command);

            try {
                $result .= self::NL.$this->runCommand($command, $timeout).self::NL;
            }
            catch (BufferedOutputException $ex) {
                $result .= $ex->getStdOutBuffer();

                throw new BufferedOutputException(
                    $ex->getMessage(),
                    $ex->getCode(),
                    $result
                );
            }
            catch (Exception $ex) {
                throw new BufferedOutputException(
                    $ex->getMessage(),
                    $ex->getCode(),
                    $result
                );
            }
        }

        return $result;
    }

    public function maskCommand($command)
    {
        $masks = $this->stringMasks;
        $masks[$this->makeTermCommand()] = '';

        $command = strtr($command, $masks);
        $command = preg_replace('/'.$this->termStr.'[0-9]+$/mD', '', $command);

        return trim($command);
    }

    private function readUntilTerm($stream, $result, $timeout = 1)
    {
        $timeStart = time();

        while (true) {
            $buffer = fread($stream, 4096);
            $result .= $buffer;

            if (strpos($result, $this->termStr) !== false) {
                break;
            }

            if (strlen($buffer)) {
                $timeStart = time();
            }

            if ((time() - $timeStart) >= $timeout) {
                break;
            }
        }

        return $result;
    }

    private function makeTermCommand()
    {
        return sprintf($this->termCmd, $this->termStr.'$?');
    }

    private function makeMasks($stringMasks)
    {
        foreach ($stringMasks as $mask) {
            $this->stringMasks[$mask] = 'xxx';
        }
    }

    private function setSocketTimeout($timeout)
    {
        $this->defaultTimeout = ini_get("default_socket_timeout");
        ini_set("default_socket_timeout", $timeout);
    }

    private function resetSocketTimeout()
    {
        ini_set("default_socket_timeout", $this->defaultTimeout);
    }

    private function extractExitCode($str)
    {
        $matches = [];

        if (preg_match('/'.$this->termStr.'([0-9]+)$/mD', $str, $matches)) {
            return $matches[1];
        }

        return 0;
    }

    private function validateKeyFile($filePath)
    {
        if (!file_exists($filePath)) {
            throw new Exception(sprintf('SSH key file not found at location `%s`', $filePath));
        }

        if (!is_readable($filePath)) {
            throw new Exception(sprintf('SSH key is not readable: `%s`', $filePath));
        }
    }
}