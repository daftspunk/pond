<?php

use PhpDeployer\HttpHandlers\NotFound as NotFoundHandler;
use PhpDeployer\HttpHandlers\Error as ErrorHandler;
use PhpDeployer\HttpHandlers\NotAllowed as NotAllowedHandler;

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
    return new NotFoundHandler(); 
};

$container['notAllowedHandler'] = function ($c) { 
    return new NotAllowedHandler(); 
};

$container['errorHandler'] = function ($c) { 
    return new ErrorHandler();
};