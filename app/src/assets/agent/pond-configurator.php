<?php namespace OctoberPond\Configurator;

use System\Classes\PluginBase;
use Request;
use Response;

/**
 * This plugin must only be used in development environments.
 *
 * It's installed and removed automatically by October Pond.
 */

class Plugin extends PluginBase
{
    public function pluginDetails()
    {
        return [
            'name'        => 'Configurator',
            'description' => 'October Pond Configurator.',
            'author'      => 'Alexey Bobkov, Samuel Georges',
            'icon'        => 'icon-cloud-upload'
        ];
    }

    public function boot()
    {
        if (!(Request::is('pond/configurator/update') && Request::isMethod('post'))) {
            Response::make('Pond Configurator plugin detected. This plugin could have been left installed because of a runtime error. Please remove it to continue: plugins/octoberpond/configurator.', 500)->send();
            die();
        }
    }
}