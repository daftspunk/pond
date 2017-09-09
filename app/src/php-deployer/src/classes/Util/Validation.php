<?php namespace PhpDeployer\Util;

use Respect\Validation\Validator as Validator;
use Exception;

class Validation
{
    public static function filePath($directoryName)
    {
        if (!Validator::notEmpty()->alnum('-_/.')->noWhitespace()->validate($directoryName)) {
            throw new Exception('File path can contain only alphanumeric, dash, forward slash, dot and underscore characters');
        }
    }
}