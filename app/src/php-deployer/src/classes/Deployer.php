<?php namespace PhpDeployer;

class Deployer
{
    public static function deployProject($request, $response, $args)
    {
        $privateKeyPath = $request->getParam('private-key-path');

        if (!strlen($privateKeyPath)) {
           throw new HttpException('Bad request: invalid argument', 400);
        }

        return $response->withJson($data);
    }
}