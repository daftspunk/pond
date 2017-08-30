<?php namespace PhpDeployer;

use Respect\Validation\Validator as Validator;

class DeployerController extends ControllerBase
{
    public function deployProject()
    {
        $this->validateDeployProjectArguments();
    }

    private function validateDeployProjectArguments()
    {
        $this->validateArgumentsExist([
            'update',
            'projectDirectoryName',
            'environmentDirectoryName'
        ]);

        if (!Validator::notEmpty()->boolType()->validate($this->getRequestArgument('update'))) {
            throw new HttpException('The update parameter should be of boolean type', 400);
        }

        if (!Validator::notEmpty()->alnum('-_')->noWhitespace()->validate($this->getRequestArgument('projectDirectoryName'))) {
            throw new HttpException('The project directory name can contain only alphanumeric, dash and underscore characters', 400);
        }

        if (!Validator::notEmpty()->alnum('-_')->noWhitespace()->validate($this->getRequestArgument('environmentDirectoryName'))) {
            throw new HttpException('The environment directory name can contain only alphanumeric, dash and underscore characters', 400);
        }
    }
}