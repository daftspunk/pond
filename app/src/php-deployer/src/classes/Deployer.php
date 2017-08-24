<?php namespace PhpDeployer;

class Deployer
{
    public static function testMe($request, $response, $args)
    {
        $data = array('name' => 'Bob', 'age' => 40);
        return $response->withJson($data);
    }
}