<?php namespace PhpDeployer\Util;

class Configuration
{
    const POND_ROOT = '/var/www';
    const UNIX_DIRECTORY_MASK = "755"; 
    const UNIX_FILE_MASK = "664";

    private static $unixConfigFileMask = "660";

    public static function getUnixConfigFileMask()
    {
        return self::$unixConfigFileMask;
    }

    public static function setWorldReadableConfigFiles()
    {
        // This is needed for unit testing, otherwise
        // tests are not able to access the config files.

        self::$unixConfigFileMask = self::UNIX_FILE_MASK;
    }
}