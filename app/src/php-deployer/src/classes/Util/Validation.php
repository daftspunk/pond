<?php namespace PhpDeployer\Util;

use Respect\Validation\Validator as Validator;
use Exception;

class Validation
{
    public static function dirName($directoryName)
    {
        if (!Validator::notEmpty()->alnum('-_/')->noWhitespace()->validate($directoryName)) {
            throw new Exception('The directory name can contain only alphanumeric, dash, forward slash and underscore characters');
        }
    }
}