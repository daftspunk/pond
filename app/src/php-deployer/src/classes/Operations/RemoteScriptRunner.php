<?php namespace PhpDeployer\Operations;

use PhpDeployer\Ssh\Connection;
use PhpDeployer\ConfigurationTemplate\View as ConfigurationTemplateView;
use PhpDeployer\Util\RequestContainer;

class RemoteScriptRunner extends Base
{
    private $variables;

    public function __construct(RequestContainer $requestContainer, Connection $connection, Connection $scpConnection, $variables)
    {
        foreach ($variables as $name=>$value) {
            $this->setVariable($name, $value);
        }

        parent::__construct($requestContainer, $connection, $scpConnection);
    }

    public function saveRemoteStatus($success)
    {
        // This operation is managed by the parent deployment operation
    }

    public function run()
    {
        $scripts = (array)$this->get('params.scripts');
        foreach ($scripts as $scriptParams) {
            $this->renderUploadAndRun($scriptParams);
        }
    }

    public function setVariable($name, $value)
    {
        $this->variables[$name] = (object)[
            'name' => $name,
            'value' => $value
        ];
    }

    protected function validateRequest()
    {
        // The request is validated by the common 
        // DEPLOYMENT_REQUIRED_ARGUMENTS schema.

        // Render to get possible template rendering 
        // problems early.

        $scripts = (array)$this->get('params.scripts');
        foreach ($scripts as $scriptParams) {
            $this->renderTemplate($scriptParams->contents, $scriptParams->type, $this->variables);
        }
    }

    private function renderTemplate($script, $type, $variables)
    {
        $view = new ConfigurationTemplateView();
        return $view->render($type, $script, $variables);
    }

    private function renderUploadAndRun($scriptParams)
    {
        $envDirectory = $this->getEnvironmentDirectoryRemotePath();
        $remoteTmpDir = $envDirectory.'/pond-tmp';
        $remoteTmpFileName = str_replace('.', '-', microtime(true)).$scriptParams->type.'.sh';
        $destRemotePath = $remoteTmpDir.'/'.$remoteTmpFileName;
        $contents = $this->renderTemplate($scriptParams->contents, $scriptParams->type, $this->variables);
        $connection = $this->getConnection();

        $params = [
            'path' => $destRemotePath
        ];

        try {
            $this->getScpConnection()->uploadFromString(
                $connection, 
                $contents,
                $destRemotePath, 
                $remoteTmpDir,
                $this->get('params.permissions.config'),
                sprintf('%s script', $scriptParams->type)
            );

            $connection->runCommand('chmod u+x "{{$path}}"', 10, $params);

            $connection->runCommand($destRemotePath, 30);
        }
        finally {
            $connection->runCommand('if [ -f "{{$path}}" ]; then rm "{{$path}}"; fi', 10, $params);
        }
    }
}