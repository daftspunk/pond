<?php namespace PhpDeployer;

use Psr\Http\Message\ServerRequestInterface; 
use Psr\Http\Message\ResponseInterface;
use Exception;

class ErrorHandler
{
    public function __invoke(ServerRequestInterface $request, ResponseInterface $response, $exception) 
    { 
        if ($exception instanceof HttpException) {
            $data = [
                'type' => 'http',
                'error' => $exception->getMessage(),
                'code' => $exception->getCode()
            ];

            return $response->withJson($data, $exception->getCode());
        }

        if ($exception instanceof BufferedOutputException) {
            $data = [
                'type' => 'command',
                'error' => $exception->getMessage(),
                'code' => $exception->getCode(),
                'output' => $exception->getStdOutBuffer()
            ];

            return $response->withJson($data, 500);
        }

        $data = [
            'type' => 'general',
            'error' => 'Server error'
        ];

        return $response->withJson($data, 500);
    }

}