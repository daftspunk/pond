<?php

use PhpDeployer\Deployer;

$app->get('/deploy', function ($request, $response, $args) {
    return Deployer::deployProject($request, $response, $args);
});
