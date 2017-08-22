<?php 

class Connection
{
    private $session;
    private $stringMasks = [];
    private $termStr = '@COMMAND-FINISHED@';
    private $termCmd = '; echo "%s"';

    /**
     * @param $stringMasks array Array of strings to be replaced with xxx value in command logs and exception messages.
     */
    public function __construct($ip, $publicKeyPath, $privateKeyPath, $userName, $stringMasks = [])
    {
        $this->session = ssh2_connect($ip, 22, array('hostkey'=>'ssh-rsa'));
        if ($this->connection === false) {
            throw new Exception(sprintf('Unable to SSH to server %s', $ip));
        }

        if (ssh2_auth_pubkey_file($this->session, $userName, $publicKey, $privateKey) === false) {
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
        $time_start = time();
        stream_set_blocking($stream, true);

        while (true) {
            $result .= fread($stream, 4096);

            if (strpos($result, $this->termStr) !== false) {
                break;
            }

            if ((time() - $time_start) > $timeout) {
                throw new Exception(sprintf('Command timed out: `%s`', $this->maskCommand($command)));
                break;
            }
        }

        @fclose($stream);
        return $result;
    }

    private function makeTermCommand()
    {
        return sprintf($this->termCmd, $this->termStr);
    }

    private function makeMasks($stringMasks)
    {
        foreach ($stringMasks as $mask) {
            $this->stringMasks[$stringMasks] = 'xxx';
        }
    }

    private function maskCommand($command)
    {
        $masks = $this->stringMasks;
        $masks[$this->makeTermCommand] = '';

        return strtr($command, $masks);
    }
}