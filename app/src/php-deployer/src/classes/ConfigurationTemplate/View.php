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

            $variables = $this->varsToTwigVariables($variables);

            return $this->getTwig()->render($name, $variables);
        }
        catch (Exception $ex) {
            throw new Exception(sprintf('Error processing template file %s: %s', $name, $ex->getMessage()));
        }
    }

    private function varsToTwigVariables($variables)
    {
        $result = [];

        foreach ($variables as $configuration) {
            $result[$configuration->name] = $configuration->value;
        }

        return $result;
    }

    private function getTwig()
    {
        if ($this->twig) {
            return $this->twig;
        }

        return $this->twig = new Twig_Environment($this->getLoader(), [
            'cache' => false,
            'strict_variables' => true,
            'autoescape' => false
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