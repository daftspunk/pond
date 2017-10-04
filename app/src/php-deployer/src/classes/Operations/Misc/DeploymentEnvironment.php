<?php namespace PhpDeployer\Operations\Misc;

use Exception;

class DeploymentEnvironment
{
    const DPE_BLUE = 'blue';
    const DPE_GREEN = 'green';

    const DPE_INITIAL = self::DPE_GREEN;
    const DPE_BOTH = [self::DPE_BLUE, self::DPE_GREEN];

    private $connection;
    private $environmentDirectory;

    public function __construct($connection, $environmentDirectory)
    {
        $this->connection = $connection;
        $this->environmentDirectory = $environmentDirectory;
    }

    public function getInactive()
    {
        $linkPath = $this->environmentDirectory.'/current';

        $path = $this->connection->runCommand('readlink "{{$linkPath}}"', 10, ['linkPath'=>$linkPath]);
        $isBlue = preg_match('/'.self::DPE_BLUE.'$/', $path);
        $isGreen = preg_match('/'.self::DPE_GREEN.'$/', $path);

        if (!$isBlue && !$isGreen) {
            throw new Exception('The "current" symbolic link has invalid target.');
        }

        if ($isBlue) {
            return self::DPE_GREEN;
        }

        return self::DPE_BLUE;
    }

    public function makeActive($environment)
    {
        if (!in_array($environment, self::DPE_BOTH)) {
            throw new HttpException('The environment name must "blue" or "green".', 400);
        }

        $parameters = [
            'envDirectory' => $this->environmentDirectory,
            'currentEnv' => $environment
        ];
        $this->connection->runCommand('ln -sfn "{{$envDirectory}}/{{$currentEnv}}" "{{$envDirectory}}/current'.'"', 10, $parameters);
    }
}