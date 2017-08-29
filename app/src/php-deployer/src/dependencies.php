<?php

use PhpDeployer\NotFoundHandler;
use PhpDeployer\ErrorHandler;

// DIC configuration

$container = $app->getContainer();

// monolog
$container['logger'] = function ($c) {
    $settings = $c->get('settings')['logger'];
    $logger = new Monolog\Logger($settings['name']);
    $logger->pushProcessor(new Monolog\Processor\UidProcessor());
    $logger->pushHandler(new Monolog\Handler\StreamHandler($settings['path'], $settings['level']));
    return $logger;
};


$container['notFoundHandler'] = function ($c) { 
    return new NotFoundHandler(null, function ($request, $response) use ($c) { 
        return $c['response'] 
            ->withStatus(404); 
    }); 
};

$container['errorHandler'] = function ($c) { 
    return new ErrorHandler();
};