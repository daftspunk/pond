<?php namespace PhpDeployer;

use Respect\Validation\Validator as Validator;

class ControllerBase
{
    protected $request;
    protected $response;
    protected $args;

    public function __construct($request, $response, $args)
    {
        $this->request = $request;
        $this->response = $response;
        $this->args = $args;

        $this->validateCommonRequestArguments();
    }

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

        $this->validateArgumentsExist([
            'privateKeyPath',
            'publicKeyPath',
            'ip',
            'user'
        ]);

        if (!Validator::notEmpty()->validate($this->getRequestArgument('privateKeyPath'))) {
            throw new HttpException('Private key path expected', 400);
        }

        if (!Validator::notEmpty()->validate($this->getRequestArgument('publicKeyPath'))) {
            throw new HttpException('Public key path expected', 400);
        }

        if (!Validator::notEmpty()->ip()->validate($this->getRequestArgument('ip'))) {
            throw new HttpException('Invalid IP address', 400);
        }

        if (!Validator::notEmpty()->regex('/[a-z_][a-z0-9_]{0,30}/')->validate($this->getRequestArgument('user'))) {
            throw new HttpException('Invalid user name', 400);
        }
    }
}