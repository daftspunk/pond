<?php namespace PhpDeployer\Util;

class Configuration
{
    const POND_ROOT = '/var/www';
    const UNIX_DIRECTORY_MASK = "755"; 
    const UNIX_FILE_MASK = "664";
    const UNIX_CONFIG_FILE_MASK = "660";

    public static function getUnixConfigFileMask()
    {
        return self::UNIX_CONFIG_FILE_MASK;
    }
}