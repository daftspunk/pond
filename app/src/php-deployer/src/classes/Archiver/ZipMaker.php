<?php namespace PhpDeployer\Archiver;

use ZipArchive;
use Exception;
use RecursiveIteratorIterator;
use RecursiveDirectoryIterator;

class ZipMaker
{
    private $ignoreFilter;
    private $rootPath;
    private $zip;

    public function __construct(IgnoreFilter $ignoreFilter, $rootPath, $archivePath)
    {
        $this->ignoreFilter = $ignoreFilter;
        $this->rootPath = realpath($rootPath);

        if (!is_dir($this->rootPath)) {
            throw new Exception('ZipMaker - the root path does not exist.');
        }

        $this->zip = new ZipArchive();
        $this->zip->open($archivePath, ZIPARCHIVE::CREATE | ZipArchive::OVERWRITE);
    }

    public function close()
    {
        $this->zip->close();
    }

    public function add($path)
    {
        if (is_dir($this->rootPath.'/'.$path)) {
            $this->addDirectoryRecursive($path);
        }
        else {
            $this->addFile($path);
        }
    }

    public function addDirectoryRecursive($dirRelativePath)
    {
        $files = new RecursiveIteratorIterator(
            new RecursiveDirectoryIterator($this->rootPath.'/'.$dirRelativePath),
            RecursiveIteratorIterator::LEAVES_ONLY
        );

        foreach ($files as $name => $file) {
            if ($file->isDir()) {
                continue;
            }

            $filePath = $file->getRealPath();
            $relativePath = substr($filePath, strlen($this->rootPath) + 1);

            if ($this->ignoreFilter->shouldIgnore($relativePath)) {
                continue;
            }

            $this->zip->addFile($filePath, $relativePath);
        }
    }

    public function addFile($fileRelativePath)
    {
        if ($this->ignoreFilter->shouldIgnore($fileRelativePath)) {
            return;
        }

        $this->zip->addFile($this->rootPath.'/'.$fileRelativePath, $fileRelativePath);
    }
}