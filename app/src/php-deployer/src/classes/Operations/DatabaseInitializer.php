<?php namespace PhpDeployer\Operations;

use PhpDeployer\Exceptions\Http as HttpException;
use Respect\Validation\Validator as Validator;
use Exception;

class DatabaseInitializer extends Base
{
    protected function validateRequest()
    {
        $this->requestContainer->validate('DEPLOYMENT_DATABASE_INIT_PARAMETERS');

        // We don't make any checks for the database
        // engine here and assume it's always MySQL,
        // as enforced by the JSON schema.

        $this->checkDatabase();
    }

    public function saveRemoteStatus($success)
    {
        // This operation is managed by the parent deployment operation
    }

    public function run()
    {
        $envDirectory = $this->getEnvironmentDirectoryRemotePath();
        $remoteTmpDir = $envDirectory.'/pond-tmp';
        $remoteTmpFileName = str_replace('.', '-', microtime(true)).'.dump';
        $destRemotePath = $remoteTmpDir.'/'.$remoteTmpFileName;

        $params = $this->makeDbConnectionParams();

        $params['dump'] = $destRemotePath; 
        $connection = $this->getConnection();

        try {
            $this->getScpConnection()->uploadFromString(
                $connection, 
                $this->get('params.databaseInit.dump'),
                $destRemotePath, 
                $remoteTmpDir,
                $this->get('params.permissions.config'),
                'Database dump'
            );

            $connection->runCommand('mysql --user="{{$u}}" --password="{{$ps}}" --host="{{$h}}" --port="{{$pr}}" "{{$d}}" < {{$dump}}', 10,  $params);
        }
        finally {
            $connection->runCommand('if [ -f "{{$dump}}" ]; then rm "{{$dump}}"; fi', 10, $params);
        }
    }

    private function checkDatabase()
    {
        $params = $this->makeDbConnectionParams();
        $connection = $this->getConnection();

        $tables = $connection->runCommand('mysql --user="{{$u}}" --password="{{$ps}}" --host="{{$h}}" --port="{{$pr}}" --execute="show tables" "{{$d}}"', 10,  $params);
        if (strlen($tables) > 0) {
            throw new Exception('Database is not empty and cannot be initialized.');
        }
    }

    private function makeDbConnectionParams()
    {
        $result = [];
        $connection = $this->getConnection();

        $result['u'] = $connection->escapeStringArgument($this->get('params.databaseInit.connection.user'));
        $result['ps'] = $connection->escapeStringArgument($this->get('params.databaseInit.connection.password'));
        $result['d'] = $connection->escapeStringArgument($this->get('params.databaseInit.connection.database'));
        $result['h'] = $connection->escapeStringArgument($this->get('params.databaseInit.connection.host'));
        $result['pr'] = $connection->escapeStringArgument($this->get('params.databaseInit.connection.port'));

        $connection->addStringMask($result['u']);
        $connection->addStringMask($result['ps']);

        return $result;
    }
}