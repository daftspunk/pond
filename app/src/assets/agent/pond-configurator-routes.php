<?php namespace OctoberPond\Configurator;

use Route;
use Request;
use File;
use Exception;
use Response;

class Configurator
{
    private $configData;
    private $configTokens;
    private $payload;
    private $configPath;
    private $head = 0;

    function __construct($payload)
    {
        $this->payload = $payload;
        $this->configPath = config_path('database.php');

        $fileContents = File::get($this->configPath);

        $this->configData = require($this->configPath);
        $this->configTokens = token_get_all($fileContents);
    }

    public function run()
    {
        $this->setDefaultConnection();
        $this->setConnectionParameters();
echo $this->stringify();
    }

    private function setDefaultConnection()
    {
        if (!isset($this->payload['database'])) {
            return;
        }

        $databasePayload = $this->payload['database'];

        if (!isset($databasePayload['default'])) {
            throw new Exception('The default connection name is not provided');
        }

        $defaultConnection = $databasePayload['default'];
        if (!isset($this->configData['connections'][$defaultConnection])) {
            throw new Exception('The connection configuration specified as default does not exist.');
        }

        $this->reset();

        if (!$this->goToNextTokenByCodeAndValue(T_CONSTANT_ENCAPSED_STRING, 'default')) {
            throw new Exception('Invalid database configuration - the default connection name is not defined.');
        }

        try {
            $this->changeArrayElementValue($defaultConnection);
        }
        catch (Exception $ex) {
            throw new Exception('Error setting default connection. '.$ex->getMessage());
        }
    }

    private function setConnectionParameters()
    {
        if (!isset($this->payload['database']['connection'])) {
            return;
        }

        if (!isset($this->payload['database']['default'])) {
            throw new Exception('Cannot set connection parameters without the default connection name specified.');
        }

        $connectionParams = $this->payload['database']['connection'];
        $defaultConnection = $this->payload['database']['default'];

        $this->reset();

        if (!$this->findArrayDefinition('connections')) {
            throw new Exception('Invalid database configuration - the connections parameter is not defined.');
        }

        if (!$this->findArrayDefinition($defaultConnection)) {
            throw new Exception(sprintf('Invalid database configuration - the %s connection parameters are not defined.', $defaultConnection));
        }

        $supportedParams = ['database', 'username', 'password', 'port'];

        foreach ($supportedParams as $param) {
            if (array_key_exists($param, $connectionParams)) {
                $this->setArrayValue($param, $connectionParams[$param]);
            }
        }
    }

    private function setArrayValue($name, $value)
    {
        if (!$this->findArrayStringValueDefinition($name)) {
            throw new Exception(sprintf('The %s connection parameter is not defined.', $name));
        }

        $this->setCurrentText("'".$value."'");
    }

    private function findArrayDefinition($parameterName)
    {
        if (!$this->goToNextTokenByCodeAndValue(T_CONSTANT_ENCAPSED_STRING, $parameterName)) {
            return false;
        }

        $this->nextAssertNotEnd();
        $this->skipWhitespace();

        if ($this->getCurrentCode() != T_DOUBLE_ARROW) {
            return $this->findArrayDefinition($parameterName);
        }

        $this->nextAssertNotEnd();
        $this->skipWhitespace();

        if ($this->getCurrentText() != '[') {
            // We should respect the "array(" notation here too.
            return $this->findArrayDefinition($parameterName);
        }

        return true;
    }

    private function findArrayStringValueDefinition($parameterName)
    {
        if (!$this->goToNextTokenByCodeAndValue(T_CONSTANT_ENCAPSED_STRING, $parameterName, [']'])) {
            return false;
        }

        $this->nextAssertNotEnd();
        $this->skipWhitespace();

        if ($this->getCurrentCode() != T_DOUBLE_ARROW) {
            return $this->findArrayStringValueDefinition($parameterName);
        }

        $this->nextAssertNotEnd();
        $this->skipWhitespace();

        if ($this->getCurrentCode() != T_CONSTANT_ENCAPSED_STRING) {
            return $this->findArrayStringValueDefinition($parameterName);
        }

        return true;
    }

    private function changeArrayElementValue($value)
    {
        $this->nextAssertNotEnd();
        $this->skipWhitespace();

        if ($this->getCurrentCode() !== T_DOUBLE_ARROW) {
            throw new Exception('T_DOUBLE_ARROW expected.');
        }

        $this->nextAssertNotEnd();
        $this->skipWhitespace();

        if ($this->getCurrentCode() != T_CONSTANT_ENCAPSED_STRING) {
            throw new Exception('Expected array value is not defined.');
        }

        $this->setCurrentText("'".$value."'");
    }

    private function stringify()
    {
        $result = null;
        foreach ($this->configTokens as $token) {
            $result .= is_array($token) ? $token[1] : $token;
        }

        return $result;
    }

    private function reset()
    {
        $this->head = 0;
    }

    private function getCurrent()
    {
        return $this->configTokens[$this->head];
    }

    private function getCurrentText()
    {
        $token = $this->getCurrent();
        if (!is_array($token)) {
            return $token;
        }

        return $token[1];
    }

    private function setCurrentText($text)
    {
        $token = $this->getCurrent();
        if (!is_array($token)) {
            $this->configTokens[$this->head] = $text;
        }

        return $this->configTokens[$this->head][1] = $text;
    }

    private function getCurrentCode()
    {
        $token = $this->getCurrent();
        if (!is_array($token)) {
            return null;
        }

        return $token[0];
    }

    private function getNext()
    {
        $nextIndex = $this->head + 1;
        if (!array_key_exists($nextIndex, $this->configTokens)) {
            return null;
        }

        $this->head = $nextIndex;
        return $this->configTokens[$nextIndex];
    }

    private function goToNextTokenByCodeAndValue($expectedCode, $expectedValue, $terminators = [])
    {
        while (($nextToken = $this->getNext()) !== null) {
            $code = $this->getCurrentCode();
            $text = $this->unquotePhpString($this->getCurrentText());

            if (in_array($code, $terminators) || in_array($text, $terminators)) {
                return false;
            }

            if ($code == $expectedCode && $text == $expectedValue) {
                return true;
            }
        }

        return false;
    }

    private function skipWhitespace()
    {
        while ($this->getCurrentCode() === T_WHITESPACE || $this->getCurrentCode() === T_COMMENT) {
            $this->getNext();
        }
    }

    private function nextAssertNotEnd()
    {
        if ($this->getNext() === null) {
            throw new Exception('Unexpected end of the configuration file.');
        }
    }

    private function unquotePhpString($string)
    {
        if ((substr($string, 0, 1) === '\'' && substr($string, -1) === '\'') || 
            (substr($string, 0, 1) === '"' && substr($string, -1) === '"')) {
            return substr($string, 1, -1);
        }

        return $string;
    }
}

Route::group(['prefix' => 'pond'], function() {
    Route::post('configure', function() {
        try {
            $payload = json_decode(Request::input('payload'), true);

            if ($payload === null) {
                throw new Exception("Invalid payload");
            }

            $configurator = new Configurator($payload);
            $configurator->run();

            print_r($payload);
        }
        catch (Exception $ex) {
            return Response::make($ex->getMessage(), 500);
        }
    });
});