<?php namespace PhpDeployer\Controllers;

use PhpDeployer\Exceptions\Http as HttpException;
use PhpDeployer\Util\RequestContainer;

class Base
{
    protected $app;

    protected $request;
    protected $response;
    protected $args;

    private $requestContainer;

    public function __construct($app, $request, $response, $args)
    {
        $this->app = $app;
        $this->request = $request;
        $this->response = $response;
        $this->args = $args;

        $this->initRequestContainer();

        // $this->validateCommonRequestArguments();
    }

    private function initRequestContainer()
    {
        $this->requestContainer = new RequestContainer((string)$this->request->getBody());
    }

    protected function getRequestContainer()
    {
        return $this->requestContainer;
    }


    /*
    protected function getRequestArgument($argument)
    {
        $body = json_decode($this->request->getBody(), true);

        if (!array_key_exists($argument, $body)) {
            throw new HttpException(sprintf('Argument %s not found in the request', $argument), 400);
        }

        return $body[$argument];
    }

    protected function validateArgumentsExist($arguments)
    {
        foreach ($arguments as $argument) {
            $this->getRequestArgument($argument);
        }
    }

    private function validateCommonRequestArguments()
    {
        $body = (string)($this->request->getBody());
        if (!Validator::json()->validate($body)) {
            throw new HttpException('JSON expected', 400);
        }

        $jsonSchema = <<<'JSON'
        {
            "type": "object",
            "properties": {
                "privateKeyPath": {
                    "type": "string"
                },
                "publicKeyPath": {
                    "type": "string"
                },
                "ip": {
                    "type": "string",
                    "format": "ipv4"
                },
                "user": {
                    "type": "string",
                    "pattern": "^[a-z_][a-z0-9_]{0,30}$"
                }
            },
            "required": [
                "privateKeyPath",
                "publicKeyPath",
                "ip",
                "user"
            ]
        }
JSON;
        $jsonSchemaObject = json_decode($jsonSchema);
        $schemaStorage = new SchemaStorage();

        $schemaStorage->addSchema('file://mySchema', $jsonSchemaObject);

        $jsonValidator = new JsonSchemaValidator(new ConstraintsFactory($schemaStorage));

        $jsonToValidateObject = (object)json_decode($this->request->getBody());

        $jsonValidator->validate($jsonToValidateObject, $jsonSchemaObject);

        if (!$jsonValidator->isValid()) {
            foreach ($jsonValidator->getErrors() as $error) { print_r($error);
                throw new HttpException(sprintf("[%s] %s\n", $error['property'], $error['message']), 400);
            }
        }

        // $this->validateArgumentsExist([
        //     'privateKeyPath',
        //     'publicKeyPath',
        //     'ip',
        //     'user'
        // ]);



        // if (!Validator::notEmpty()->validate($this->getRequestArgument('privateKeyPath'))) {
        //     throw new HttpException('Private key path expected', 400);
        // }

        // if (!Validator::notEmpty()->validate($this->getRequestArgument('publicKeyPath'))) {
        //     throw new HttpException('Public key path expected', 400);
        // }

        // if (!Validator::notEmpty()->ip()->validate($this->getRequestArgument('ip'))) {
        //     throw new HttpException('Invalid IP address', 400);
        // }

        // if (!Validator::notEmpty()->regex('/^[a-z_][a-z0-9_]{0,30}$/i')->validate($this->getRequestArgument('user'))) {
        //     throw new HttpException('Invalid user name', 400);
        // }
    }
    */
}