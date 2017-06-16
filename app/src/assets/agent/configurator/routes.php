<?php namespace OctoberPond\Configurator;

use Db;
use PDO;
use Route;
use Request;
use File;
use Exception;
use Response;
use Config;
use Str;
use October\Rain\Config\ConfigWriter;
use Illuminate\Encryption\Encrypter;
use System\Classes\UpdateManager;

class Configurator
{
    private $payload;
    private $configWriter;

    private $updatedConfiguration;

    function __construct($payload)
    {
        $this->payload = $payload;
        $this->configWriter = new ConfigWriter;

        $this->configCache = [];
    }

    public function run()
    {
        $this->configureDatabase();
        $this->configureEncryptionKey();
        $this->setupAdminUser();

        $this->writeConfig();
        $this->runMigrations();
    }

    private function configureDatabase()
    {
        $configPath = config_path('database.php');
        $configData = require($configPath);

        if (!isset($this->payload['database'])) {
            return;
        }

        $databasePayload = $this->payload['database'];

        if (!isset($databasePayload['default'])) {
            throw new Exception('The default connection name is not provided');
        }

        $defaultConnection = $databasePayload['default'];
        if (!isset($configData['connections'][$defaultConnection])) {
            throw new Exception('The connection configuration specified as default does not exist.');
        }

        $this->setConfig('database', ['default'=>$defaultConnection]);
        if ($defaultConnection === 'sqlite') {
            $this->setupDatabaseSqlite();
        }

        if (!isset($this->payload['database']['connection'])) {
            return;
        }

        if (!isset($this->payload['database']['default'])) {
            throw new Exception('Cannot set connection parameters without the default connection name specified.');
        }

        $connectionParams = $this->payload['database']['connection'];

        $supportedParams = [
            'database', 
            'username', 
            'password', 
            'port'
        ];

        foreach ($supportedParams as $param) {
            if (array_key_exists($param, $connectionParams)) {
                $this->setConfig('database', ['connections.'.$defaultConnection.'.'.$param=>$connectionParams[$param]]);
            }
        }
    }

    private function configureEncryptionKey()
    {
        $cipher = Config::get('app.cipher');

        if (!isset($this->payload['encryptionKey'])) {
            $key = $this->getRandomKey($cipher);
        }
        else {
            $providedKey = $this->payload['encryptionKey'];

            if (!Encrypter::supported($providedKey, $cipher)) {
                $keyLength = $this->getKeyLength($cipher);
                throw new Exception(sprintf('Invalid key length for "%s" cipher. Supplied key must be %s characters in length.', $cipher, $keyLength));
            }

            $key = $providedKey;
        }

        $this->setConfig('app', ['key'=>$key]);
    }

    private function runMigrations()
    {
        try {
            Db::purge();
            UpdateManager::instance()->resetNotes()->update();
        }
        catch (Exception $ex) {

            throw new Exception('Error running database migrations. '.$ex->getMessage());
        }
    }

    private function setupAdminUser()
    {
        // TODO
    }

    private function setConfig($file, $parameters)
    {
        if (!array_key_exists($file, $this->configCache)) {
            $this->configCache[$file] = [];
        }

        $this->configCache[$file] = array_merge($this->configCache[$file], $parameters);
    }

    private function writeConfig()
    {
        foreach ($this->configCache as $file=>$parameters) {
            $path = config_path($file.'.php');

            foreach ($parameters as $key=>$value) {
                Config::set($file.'.'.$key, $value);
            }

            $this->configWriter->toFile($path, $parameters);
        }
    }

    protected function setupDatabaseSqlite()
    {
        $filename = Config::get('database.connections.sqlite.database');

        if (!file_exists($filename)) {
            $directory = dirname($filename);
            if (!is_dir($directory)) {
                mkdir($directory, 0777, true);
            }

            new PDO('sqlite:'.$filename);
        }
    }

    private function getRandomKey($cipher)
    {
        return Str::random($this->getKeyLength($cipher));
    }

    private function getKeyLength($cipher)
    {
        return $cipher === 'AES-128-CBC' ? 16 : 32;
    }
}

Route::group(['prefix' => 'pond'], function() {
    Route::post('configure', function() {
        try {
            $payload = json_decode(Request::input('payload'), true);
print_r($payload);
            if ($payload === null) {
                throw new Exception("Invalid payload");
            }

            $configurator = new Configurator($payload);
            $configurator->run();

            echo "DONE";
        }
        catch (Exception $ex) {
            return Response::make($ex->getMessage(), 500);
        }
    });
});