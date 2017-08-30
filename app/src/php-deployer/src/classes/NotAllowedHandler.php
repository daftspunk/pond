<?php namespace PhpDeployer;

use Slim\Handlers\NotFound; 
use Psr\Http\Message\ServerRequestInterface; 
use Psr\Http\Message\ResponseInterface;

class NotAllowedHandler
{
    public function __invoke(ServerRequestInterface $request, ResponseInterface $response, $methods) 
    { 
        $data = [
            'type' => 'http',
            'error' => 'Method not allowed'
        ];

        return $response->withJson($data, 405);
    }

}