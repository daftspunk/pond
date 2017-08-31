<?php namespace PhpDeployer\Exceptions;

use Exception;

/**
 * Keeps the stdoout buffer, stderr buffer and exit code for a failed command.
 * The stderr buffer is the exception message;
 */
class BufferedOutput extends Exception
{
    private $stdOutBuffer = null;

    public function __construct($message, $code = 0, $stdOutBuffer = null, Exception $previous = null)
    {
        $this->stdOutBuffer = $stdOutBuffer;

        parent::__construct($message, $code, $previous);
    }

    public function getStdOutBuffer()
    {
        return $this->stdOutBuffer;
    }
}