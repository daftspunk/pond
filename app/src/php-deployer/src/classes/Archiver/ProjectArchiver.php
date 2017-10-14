<?php namespace PhpDeployer\Archiver;

use Exception;

class ProjectArchiver
{
    private $projectPath;
    private $disableIgnorePaths;

    private $components = [
        'core' => [
            '.pondgitdir',    // This is for unit testing purposes only
            '.git',           // We support git, unless it's removed with .pondignore
            '.gitignore',
            '.htaccess',
            'index.php',
            'artisan',
            'bootstrap',
            'modules',
            'vendor'
        ],
        'media' => [
            'storage/app/media'
        ],
        'uploads' => [
            'storage/app/uploads'
        ],
        'plugins' => 'plugins',
        'themes' => 'themes'
    ];

    private $allComponents = [
        'core'=>true, 
        'media'=>true,
        'uploads'=>true,
        'plugins'=>true,
        'themes'=>true
    ];

    private $archivedComponentPaths;
    private $archivedComponents;

    public function __construct($projectPath, $disableIgnorePaths = false)
    {
        $this->projectPath = $projectPath;
        $this->disableIgnorePaths = $disableIgnorePaths;
    }

    /**
     * Creates a ZIP archive from the project directory.
     *
     * The method takes into account .pondignore file, if it
     * exists in the project directory.
     *
     * @param array $components Array of October CMS project components to include.
     * Full structure, everything is optional:
     * [
     *   'core' => true,
     *   'media' => true,
     *   'uploads' => true,
     *   'plugins' => true|['rainlab/users', 'rainlab/editor']
     *   'themes' => true|['website-final', 'website-draft']
     *   'config' => true
     * ]
     * @return string Returns a path to the archive
     */
    public function make(array $components = null)
    {
        if ($components === null) {
            $components = $this->allComponents;
        }

        $this->archivedComponents = $components;
        $this->archivedComponentPaths = [];

        $ignorePaths = $this->getIgnorePaths();
        $ignoreFilter = new IgnoreFilter($ignorePaths);

        $tempFilePath = tempnam(sys_get_temp_dir(), 'pond_');

        if ($tempFilePath == false) {
            throw new Exception('Cannot create temporary file');
        }

        $zipMaker = new ZipMaker($ignoreFilter, $this->projectPath, $tempFilePath);

        foreach ($components as $component=>$componentConfig) {
            if ($componentConfig) {
                $this->addComponent($zipMaker, $component, $componentConfig);
            }
        }

        $zipMaker->close();

        return $tempFilePath;
    }

    /**
     * Returns paths to files and top-level directories that were archived with the last make() call.
     */
    public function getArchivedComponentPaths()
    {
        return $this->archivedComponentPaths;
    }

    public function getArchivedComponents()
    {
        $result = [];
        foreach ($this->archivedComponents as $component=>$componentConfig) {
            $configIsArray = is_array($componentConfig);

            if (!$configIsArray) {
                if ($componentConfig === true) {
                    $result[] = $component;
                }
                continue;
            }
            else {
                foreach ($componentConfig as $configPath) {
                    $result[] = $component.'/'.$configPath;
                }
            }
        }

        return $result;
    }

    private function addComponent($zip, $component, $componentConfig)
    {
        if (!array_key_exists($component, $this->components)) {
            throw new Exception(sprintf('Unknown component: ', $component));
        }

        $componentPaths = $this->components[$component];

        if (is_array($componentPaths)) {
            // Core, media, uploads, config

            foreach ($componentPaths as $path) {
                $this->addPathToZip($zip, $path);
            }
        }
        else {
            // Plugins and themes, configured as ['plugins'=>true] 
            // or ['plugins'=>['author/plugin', 'author/plugin']]

            if (!is_array($componentConfig) && $componentConfig !== true) {
                throw new Exception(sprintf('The %s component configuration must be either TRUE or an array', $component));
            }

            if ($componentConfig === true) {
                $this->addPathToZip($zip, $componentPaths);
                return;
            }

            foreach ($componentConfig as $configPath) {
                if (!preg_match('/^[0-9a-z_\-\/]+$/i', $configPath)) {
                    throw new Exception(sprintf('Invalid value passed to the %s component configuration: %s', $component, $configPath));
                }

                $this->addPathToZip($zip, $componentPaths.'/'.$configPath);
            }
        }
    }

    private function addPathToZip($zip, $path)
    {
        $this->archivedComponentPaths[] = $path;
        $zip->add($path);
    }

    private function getIgnorePaths()
    {
        // This is for unit testing.
        if ($this->disableIgnorePaths) {
            return [];
        }

        $path = $this->projectPath.'/.pondignore';

        if (!file_exists($path)) {
            return [];
        }

        $lines = file($path, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
        $result = [];

        foreach ($lines as $line) {
            $line = trim($line);

            if (substr($line, 0, 1) != '#') {
                $result[] = $line;
            }
        }

        return $result;
    }
}