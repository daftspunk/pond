<?php namespace PhpDeployer\Archiver;

class IgnoreFilter
{
    private $filters;

    public function __construct($filters)
    {
        $this->filters = $filters;
    }

    public function shouldIgnore($path)
    {
        $path = str_replace('\\', '/', $path);

        if (substr($path, 0, 1) != '/') {
            $path = '/'.$path;
        }

        // If an ignore path starts with "/"
        // it means that we must ignore all paths that
        // start with the ignore path, from the root.
        //
        // Otherwise we just check if the ignore path is
        // a part of the path being inspected.

        foreach ($this->filters as $pathToIgnore) {
            if (substr($pathToIgnore, 0, 1) == '/') {
                if (substr($path, 0, strlen($pathToIgnore)) === $pathToIgnore) {
                    return true;
                }
            }
            else {
                if (strpos($path, $pathToIgnore) !== false) {
                    return true;
                }
            }
        }

        return false;
    }
}