<?php

$app->get('/validate-host', function ($request, $response, $args) {
    Deployer::testMe();

    $this->logger->info("PHP deployer'/validate-host' route");

    $data = array('name' => 'Bob', 'age' => 40);
    return $response->withJson($data);
});
