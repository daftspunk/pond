<?php namespace PhpDeployer\Operations\Misc;

use PhpDeployer\Exceptions\Http as HttpException;
use Respect\Validation\Validator as Validator;

class RequestPermissionData
{
    // The following properties must stay private.

    private $directoryMask;
    private $configMask;
    private $fileMask;

    public function __construct($directoryMask, $configMask, $fileMask)
    {
        $this->directoryMask = $directoryMask;
        $this->configMask = $configMask;
        $this->fileMask = $fileMask;

        if (!Validator::notEmpty()->regex('/^[0-9]{3}$/i')->validate($this->directoryMask)) {
            throw new HttpException('The directory permission mask should not be empty and be a valid permission value', 400);
        }

        if (!Validator::notEmpty()->regex('/^[0-9]{3}$/i')->validate($this->configMask)) {
            throw new HttpException('The config permission mask should not be empty and be a valid permission value', 400);
        }

        if (!Validator::notEmpty()->regex('/^[0-9]{3}$/i')->validate($this->fileMask)) {
            throw new HttpException('The file permission mask should not be empty and be a valid permission value', 400);
        }
    }

    public function getDirectoryMask()
    {
        return $this->directoryMask;
    }

    public function getConfigMask()
    {
        return $this->configMask;
    }

    public function getFileMask()
    {
        return $this->fileMask;
    }
}