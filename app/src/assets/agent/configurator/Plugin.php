<?php namespace OctoberPond\Configurator;

use System\Classes\PluginBase;
use Request;
use Response;

/**
 * This plugin must only be used in development environments.
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
        if (!(Request::is('pond/configure') && Request::isMethod('post'))) {
            Response::make('Pond Configurator plugin detected. This plugin could have been left installed because of a fatal error. Please remove it to continue: plugins/octoberpond/configurator.', 500)->send();
            die();
        }
    }
}