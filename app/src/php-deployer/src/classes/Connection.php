<?php namespace PhpDeployer;

use Exception;

class Connection
{
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

    public function runCommand($command, $timeout = 10)
    {
        $command .= $this->makeTermCommand();
        $stream = ssh2_exec($this->session, $command);

        if (!$stream) {
            throw new Exception(sprintf('Error executing command `%s`', $this->maskCommand($command)));
        }

        $result = '';
        $timeStart = time();

        $stdOutStream = ssh2_fetch_stream($stream, SSH2_STREAM_STDIO);
        $stdErrStream = ssh2_fetch_stream($stream, SSH2_STREAM_STDERR);

        try {
            while (true) {
                $stdOutBuffer = fread($stdOutStream, 4096);
                $stdErrBuffer = fread($stdErrStream, 4096);

                if ($stdErrBuffer) {
                    throw new Exception($this->maskCommand($stdErrBuffer));
                }

                if (strlen($stdOutBuffer)) {
                    // If the command returns any output during the execution,
                    // we don't consider it timing out. The timeout is always
                    // measured since the last time we heard anything from 
                    // the command.

                    $timeStart = time();
                }

                $result .= $stdOutBuffer;

                if (strpos($result, $this->termStr) !== false) {
                    break;
                }

                if ((time() - $timeStart) > $timeout) {
                    throw new Exception(sprintf('Command timed out: `%s`', $this->maskCommand($command)));
                }
            }
        }
        finally {
            @fclose($stdOutStream);
            @fclose($stdErrStream);
            @fclose($stream);
        }

        $matches = [];
        if (preg_match('/'.$this->termStr.'([0-9]+)$/mD', $result, $matches)) {
            if ($matches[1] != 0) {
                throw new ErrorOutputException($this->maskCommand($result), $matches[1]);
            }
        }

        return $this->maskCommand($result);
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

    private function maskCommand($command)
    {
        $masks = $this->stringMasks;
        $masks[$this->makeTermCommand()] = '';

        $command = strtr($command, $masks);
        $command = preg_replace('/'.$this->termStr.'[0-9]+$/mD', '', $command);

        return $command;
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