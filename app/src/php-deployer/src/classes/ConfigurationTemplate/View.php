<?php namespace PhpDeployer\ConfigurationTemplate;

use Twig_Loader_Array;
use Twig_Environment;
use Exception;

class View
{
    private $twig;
    private $loader;

    public function __construct()
    {
    }

    public function render($name, $source, $variables = [])
    {
        try {
            $this->getLoader()->setTemplate($name, $source);

            return $this->getTwig()->render($name, $variables);
        }
        catch (Exception $ex) {
            throw new Exception(sprintf('Error processing configuration file template: %s', $ex->getMessage()));
        }
    }

    private function getTwig()
    {
        if ($this->twig) {
            return $this->twig;
        }

        return $this->twig = new Twig_Environment($this->getLoader(), [
            'cache' => false,
            'strict_variables' => true
        ]);
    }

    private function getLoader()
    {
        if ($this->loader) {
            return $this->loader;
        }

        return $this->loader = new Twig_Loader_Array();
    }
}