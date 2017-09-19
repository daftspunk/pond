<?php namespace PhpDeployer\Ssh;

use PhpDeployer\Exceptions\BufferedOutput as BufferedOutputException;
use PhpDeployer\Util\Validation as ValidationUtil;
use Respect\Validation\Validator as Validator;
use Exception;

class Connection
{
    const NL = "\n"; // Don't depend on the platform new line. The target servers are Unix-based and always use \n.

    private $session;
    private $stringMasks = [];
    private $termStr = '@COMMAND-FINISHED@';
    private $termCmd = '; echo "%s"';
    private $singleCommandHasRun = false;

    private $defaultTimeout;
    private $logCallable;

    private $commandLog = [];

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

    public function setLogCallable(callable $logCallable)
    {
        $this->logCallable = $logCallable;
    }

    public function getLogAsArray()
    {
        return $this->commandLog;
    }

    /**
     * Executes a single command and returns its result.
     *
     * Throws BufferedOutputException or Exception in case of issues.
     * 
     * @param string $command Command to execute
     * @param int $timeout Timeout for executing the command
     * @param array $variables A list of variable name and values to replace placeholders in commands.
     * The placeholder syntax is {{$var}}. Variables are not escaped or sanitized, this must be
     * done in the calling code.
     * @return string Returns the stdout buffer
     */
    public function runCommand($command, $timeout = 10, array $variables = [])
    {
        $this->addToLog('$ '.$this->maskCommand($this->replaceVariables($command, $variables)));

        try {
            $result = $this->runCommandInternal($command, $timeout, $variables);
        }
        catch (BufferedOutputException $ex) {
            $stdOutBuffer = $ex->getStdOutBuffer();
            if (strlen($stdOutBuffer) > 0) {
                $this->addToLog($stdOutBuffer);
            }

            $this->addToLog($ex->getMessage());

            throw $ex;
        }
        catch (Exception $ex) {
            $this->addToLog($ex->getMessage());

            throw $ex;
        }

        $this->addToLog($result);
        return $result;
    }

    /**
     * Runs multiple commands separated with the newline character.
     * Commands should not be related bound to each other, e.g. there
     * should not be multi-line expressions, condition structures,
     * variable assignments, etc.
     *
     * The log (set with setLogCallable) will contain commands themselves
     * and their output. In case of an general exception, the exception
     * message won't get to the log and can be accessed through the thrown 
     * BufferedOutputException::getMessage() method. The log still contains
     * all the messages, including the exception message.
     * 
     * @param string|array $commandsStr Commands to execute
     * @param int $timeout Timeout for executing a single command.
     * @param array $variables A list of variable name and values to replace placeholders in commands.
     * The placeholder syntax is {{$var}}. Variables are not escaped or sanitized, this must be
     * done in the calling code.
     * @return string Returns the stdout buffer
     */
    public function runMultipleCommands($commands, $timeout = 10, array $variables = [])
    {
        if (!is_string($commands) && !is_array($commands)) {
            throw new Exception('The commands argument must be a string or array.');
        }

        if (!is_array($commands)) {
            $commands = str_replace("\r\n", self::NL, $commands);
            $commands = explode(self::NL, $commands);
        }

        $result = '';
        foreach ($commands as $command) {
            $command = trim($command);
            if (!strlen($command)) {
                continue;
            }

            // Apply the variables here to prevent leaking their values
            // through $result.
            $command = $this->replaceVariables($command, $variables);

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

    public function upload($from, $to)
    {
        if ($this->singleCommandHasRun) {
            throw new Exception('Cannot use a same SSH connection for running commands and uploading files.');
        }

        $this->addToLog(sprintf('Uploading "%s"...', $to));

        if (!@ssh2_scp_send($this->session, $from, $to)) {
            throw new Exception($this->addToLog('Error uploading file to the server'));
        }
    }

    public function uploadFromString($commandSshConnection, $contents, $to, $remoteTmpDir, $permissionMask)
    {
        if ($this->singleCommandHasRun) {
            throw new Exception('Cannot use a same SSH connection for running commands and uploading files.');
        }

        $localTmpPath = tempnam(sys_get_temp_dir(), 'pond_');
        try {
            $remoteTmpFileName = str_replace('.', '-', microtime(true));
            $destRemotePath = $remoteTmpDir.'/'.$remoteTmpFileName;

            if (file_put_contents($localTmpPath, $contents) === false) {
                throw new Exception('Cannot create a local temporary file');
            }

            $this->upload($localTmpPath, $destRemotePath);

            $params = [
                'tmpPath' => $destRemotePath,
                'destPath' => $to,
                'mask' => $permissionMask
            ];

            try {
                $commandSshConnection->runCommand('mv "{{$tmpPath}}" "{{$destPath}}"', 30, $params);
                $commandSshConnection->runCommand('chmod {{$mask}} "{{$destPath}}"', 10,  $params);
            }
            finally {
                $commandSshConnection->runCommand('if [ -f "{{$tmpPath}}" ]; then rm "{{$tmpPath}}"; fi', $params);
            }
        }
        finally {
            @unlink($localTmpPath);
        }
    }

    //
    // Convenience functions
    //

    public function directoryExists($directoryName)
    {
        ValidationUtil::filePath($directoryName);

        return $this->runCommand('if [ -d "'.$directoryName.'" ]; then echo "exists"; fi') === 'exists';
    }

    public function makeDirIfNotExists($directoryName, $permissionMask)
    {
        ValidationUtil::filePath($directoryName);

        if (!Validator::notEmpty()->alnum()->noWhitespace()->validate($permissionMask)) {
            throw new Exception('Invalid permission mask in makeDirIfNotExists() call');
        }

        return $this->runCommand('mkdir -m '.$permissionMask.' -p "'.$directoryName.'"');
    }

    public function fileExists($fileName)
    {
        ValidationUtil::filePath($fileName);

        return $this->runCommand('if [ -f "'.$fileName.'" ]; then echo "exists"; fi') === 'exists';
    }

    public function getClientIp()
    {
        return $this->runCommand('echo $SSH_CONNECTION | awk \'{print $1}\'');
    }

    public function getRemoteDateTime()
    {
        return $this->runCommand('date +"%Y-%m-%d %T"');
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

    private function runCommandInternal($command, $timeout = 10, array $variables = [])
    {
        $this->singleCommandHasRun = true;

        if (substr($command, -2) != '\;') {
            $command = rtrim($command, ';');
        }

        $command = $command.$this->makeTermCommand();
        $command = $this->replaceVariables($command, $variables);

        $stream = @ssh2_exec($this->session, $command);

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

    private function replaceVariables($command, $variables)
    {
        foreach ($variables as $name=>$value) {
            $command = str_replace('{{$'.$name.'}}', $value, $command);
        }

        return $command;
    }

    private function addToLog($string)
    {
        $string = trim($string);

        if (!strlen($string)) {
            return;
        }

        $this->commandLog[] = $string;

        if ($this->logCallable) {
            $callable = $this->logCallable;
            $callable($string);
        }

        return $string;
    }
}