<?php

use PhpDeployer\Controllers\Deployment;

$app->post('/deploy', function ($request, $response, $args) use ($app) {
    $controller = new Deployment($app, $request, $response, $args);

    return $controller->deployProject();
});

$app->post('/configure', function ($request, $response, $args) use ($app) {
    $controller = new Deployment($app, $request, $response, $args);

    return $controller->configureProject();
});

$app->post('/swap', function ($request, $response, $args) use ($app) {
    $controller = new Deployment($app, $request, $response, $args);

    return $controller->swapEnvironments();
});
