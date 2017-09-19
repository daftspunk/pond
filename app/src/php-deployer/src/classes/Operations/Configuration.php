<?php namespace PhpDeployer\Operations;

use PhpDeployer\Exceptions\Http as HttpException;
use PhpDeployer\Util\Configuration as DeployerConfiguration;
use PhpDeployer\ConfigurationTemplate\View as ConfigurationTemplateView;
use Respect\Validation\Validator as Validator;
use Exception;

/**
 * Performs project configuration on a target server.
 */
class Configuration extends Base
{
    // The following properties must stay private.
    // If they're set from external sources, their
    // values must be validated.

    private $templates;
    private $localProjectPath;

    public function setConfigurationParameters($parameters)
    {
        $this->setProjectDirectoryName($this->getParameterValue($parameters, 'projectDirectoryName'));
        $this->setEnvironmentDirectoryName($this->getParameterValue($parameters, 'environmentDirectoryName'));
        $this->templates = $this->getParameterValue($parameters, 'configTemplates');

        if (!Validator::arrayType()->validate($this->templates)) {
            throw new HttpException('The configTemplates parameter should be an array', 400);
        }

        foreach ($this->templates as $templateName=>$templateConfiguration) {
            if (!Validator::notEmpty()->regex('/^[0-9a-z_-]+\.php$/i')->validate($templateName)) {
                throw new HttpException(sprintf('Invalid configuration template name: %s', $templateName), 400);
            }

            if (!array_key_exists('template', $templateConfiguration)) {
                throw new HttpException(sprintf('The template parameter is not found for %s configuration template', $templateName), 400);
            }

            if (!array_key_exists('vars', $templateConfiguration)) {
                throw new HttpException(sprintf('The vars parameter is not found for %s configuration template', $templateName), 400);
            }

            if (!Validator::stringType()->validate($templateConfiguration['template'])) {
                throw new HttpException(sprintf('The template for %s configuration template must be a string', $templateName), 400);
            }

            if (!Validator::arrayType()->validate($templateConfiguration['vars'])) {
                throw new HttpException(sprintf('The variables for %s configuration template must be an array', $templateName), 400);
            }

            // Do this to fail early if there are syntax errors,
            // undefined variables or other issues in the templates.
            $this->renderTemplate($templateName, $templateConfiguration['template'], $templateConfiguration['vars']);
        }
    }

    private function renderTemplate($name, $source, $variables)
    {
        $view = new ConfigurationTemplateView();
        return $view->render($name, $source, $variables);
    }

    public function run()
    {
        $connection = $this->getConnection();

        $configDirectory = $this->getEnvironmentDirectoryRemotePath().'/config';
        if (!$connection->directoryExists($configDirectory)) {
            throw new Exception(sprintf('The environment configuration directory is not found on the server: %s', $configDirectory));
        }

        foreach ($this->templates as $templateName=>$templateConfiguration) {
            $this->renderAndUpload($templateName, $templateConfiguration, $configDirectory);
        }
    }

    public function saveRemoteStatus($success)
    {
        $logRecordDetails = RemoteStatusManager::makeLogRecordArray(
            $success, 
            ['config'], 
            ['blue', 'green']);

        $this->updateRemoteStatus($logRecordDetails, null);
    }

    private function renderAndUpload($templateName, $templateConfiguration, $configDirectory)
    {
        $tempFilePath = tempnam(sys_get_temp_dir(), 'pond_');

        if ($tempFilePath == false) {
            throw new Exception('Cannot create temporary file for a configuration file');
        }

        try {
            $contents = $this->renderTemplate($templateName, $templateConfiguration['template'], $templateConfiguration['vars']);
            if (@file_put_contents($tempFilePath, $contents) === false) {
                throw new Exception('Cannot save configuration template string to a temporary file');
            }

            $destRemotePath = $configDirectory.'/'.$templateName;
            $this->getScpConnection()->upload($tempFilePath, $destRemotePath);
            $this->getConnection()->runCommand('chmod {{$mask}} "{{$path}}"', 10, [
                'mask' => DeployerConfiguration::getUnixConfigFileMask(),
                'path' => $destRemotePath
            ]);
        }
        finally {
            @unlink($tempFilePath);
        }
    }
}