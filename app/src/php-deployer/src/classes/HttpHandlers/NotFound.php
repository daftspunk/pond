<?php namespace PhpDeployer\Handlers;

use Slim\Handlers\NotFound; 
use Psr\Http\Message\ServerRequestInterface; 
use Psr\Http\Message\ResponseInterface;

class NotFound extends NotFound 
{
    public function __invoke(ServerRequestInterface $request, ResponseInterface $response) 
    { 
        parent::__invoke($request, $response);

        $data = [
            'type' => 'http',
            'error' => 'Not found',
        ];

        return $response->withJson($data, 404);
    }

}