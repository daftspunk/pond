<?php namespace PhpDeployer\Operations;

use PhpDeployer\Exceptions\Http as HttpException;
use PhpDeployer\ConfigurationTemplate\View as ConfigurationTemplateView;
use PhpDeployer\Operations\Misc\DeploymentEnvironment;
use PhpDeployer\Operations\Misc\RemoteStatusManager;
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

    protected function validateRequest()
    {
        $this->requestContainer->validate('CONFIGURATION_REQUIRED_ARGUMENTS');

        foreach ($this->get('params.configTemplates') as $templateConfiguration) {
            // Do this to fail early if there are syntax errors,
            // undefined variables or other issues in the templates.
            $this->renderTemplate($templateConfiguration->file, $templateConfiguration->template, $templateConfiguration->vars);
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

        foreach ($this->get('params.configTemplates') as $templateConfiguration) {
            $this->renderAndUpload($templateConfiguration, $configDirectory);
        }
    }

    public function saveRemoteStatus($success)
    {
        $logRecordDetails = RemoteStatusManager::makeLogRecordArray(
            $success, 
            ['config'], 
            DeploymentEnvironment::DPE_BOTH,
            RemoteStatusManager::TYPE_CONFIG
        );

        $this->updateRemoteStatus($logRecordDetails, null);
    }

    private function renderAndUpload($template, $configDirectory)
    {
        $envDirectory = $this->getEnvironmentDirectoryRemotePath();
        $destRemotePath = $configDirectory.'/'.$template->file;
        $remoteTmpDir = $envDirectory.'/pond-tmp';
        $contents = $this->renderTemplate($template->file, $template->template, $template->vars);

        $this->getScpConnection()->uploadFromString(
            $this->getConnection(), 
            $contents,
            $destRemotePath, 
            $remoteTmpDir,
            $this->get('params.permissions.config'),
            $template->file
        );
    }
}