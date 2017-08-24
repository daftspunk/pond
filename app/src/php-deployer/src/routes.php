<?php

use PhpDeployer\Deployer;

$app->get('/validate-host', function ($request, $response, $args) {
    return Deployer::testMe($request, $response, $args);
});
