<?php namespace PhpDeployer\Exceptions;

use Exception; 

class Http extends Exception
{
    public function __construct($message, $code = 500, Exception $previous = null)
    {
        parent::__construct($message, $code, $previous);
    }
}