<?php namespace PhpDeployer\Archiver;

use Exception;

class ProjectArchiver
{
    private $projectPath;

    private $components = [
        'core' => [
            '.git/*',         // We support git, unless it's removed with .pondignore
            '.gitignore',
            '.htaccess',
            'index.php',
            'artisan',
            'bootstrap/*'
            'modules/*',
            'vendor/*'
        ],
        'media' => [
            'storage/app/media/*'
        ],
        'uploads' => [
            'storage/app/uploads/*'
        ],
        'plugins' => 'plugins/',
        'themes' => 'themes/',
        'config' => [
            'config/*'
        ]
    ];

    public function __construct($projectPath)
    {
        $this->projectPath = $projectPath;
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
    public function make(array $components)
    {
        $ignorePaths = $this->getIgnorePaths();
        $ignoreFilter = new IgnoreFilter($ignorePaths);

        $tempFilePath = tempnam(sys_get_temp_dir(), 'pond_');

        if ($tempFilePath == false) {
            throw new Exception('Cannot create temporary file');
        }

        Zip::make($tempFilePath, $ignoreFilter, function($zip) {
            foreach ($components as $component=>$componentConfig) {
                if ($componentConfig) {
                    $this->addComponent($zip, $component, $componentConfig, $ignorePaths);
                }
            }
        });

        return $tempFilePath;
    }

    private function addComponent($zip, $component, $componentConfig, $ignorePaths)
    {
        if (!array_key_exists($component, $this->components)) {
            throw new Exception(sprintf('Unknown component: ', $component));
        }

        $componentPaths = $this->components[$component];

        if (is_array($componentPaths)) {
            // Core, media, uploads, config

            foreach ($componentPaths as $path) {
                $zip->add($path, ['ignore'=>$ignorePaths]);
            }
        }
        else {
            // Plugins and themes, configured as ['plugins'=>true] 
            // or ['plugins'=>['author/plugin', 'author/plugin']]

            if (!is_array($componentConfig)) {
                throw new Exception(sprintf('The %s component configuration must be either TRUE or an array', $component));
            }

            foreach ($componentConfig as $configPath) {
                if (!preg_match('/^[0-9a-z_-\/]+$/i'), $configPath) {
                    throw new Exception(sprintf('Invalid value passed to the %s component configuration: %s', $component, $configPath));
                }

                $zip->add($componentPaths.$configPath.'/*', ['ignore'=>$ignorePaths]);
            }
        }
    }

    private function getIgnorePaths()
    {
        $path = $this->projectPath.'/.pondignore';

        if (!file_exists($path) {
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