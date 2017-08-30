<?php

use PhpDeployer\DeployerController;

$app->post('/deploy', function ($request, $response, $args) {
    $controller = new DeployerController($request, $response, $args);

    return $controller->deployProject();
});
