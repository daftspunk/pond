<?php namespace PhpDeployer\Util;

use PhpDeployer\Exceptions\Http as HttpException;
use Respect\Validation\Validator as Validator;
use JsonSchema\Validator as JsonSchemaValidator;
use JsonSchema\SchemaStorage;
use JsonSchema\Constraints\Factory as ConstraintsFactory;
use Exception;

/**
 * Validates input parameters and returns their values.
 */
class RequestContainer
{
    // The following properties must
    // stay private.

    private $requestJsonObject;

    public function __construct($requestJsonString)
    {
        if (!Validator::json()->validate($requestJsonString)) {
            throw new HttpException('JSON expected', 400);
        }

        $this->requestJsonObject = json_decode($requestJsonString);
    }

    public function validate($schemaName)
    {
        $schemaString = $this->getSchemaByName($schemaName);

        return $this->validateWithSchemaString($schemaString, $schemaName);
    }

    public function validateCustomSchema($schemaString, $schemaName)
    {
        return $this->validateWithSchemaString($schemaString, $schemaName);
    }

    public function get($path, $optional = false, $default = null)
    {
        $parts = explode('.', $path);

        return $this->getValueByPath($parts, $this->requestJsonObject, $path, $optional, $default);
    }

    private function validateWithSchemaString($schemaString, $schemaName)
    {
        $targetSchemaObject = $this->makeTargetSchemaObject($schemaString, $schemaName);

        $schemaStorage = new SchemaStorage();
        $schemaStorage->addSchema('file://pond', $targetSchemaObject);

        $constraintsFactory = new ConstraintsFactory($schemaStorage);

        $jsonValidator = new JsonSchemaValidator($constraintsFactory);
        $jsonValidator->validate($this->requestJsonObject, $targetSchemaObject);

        if (!$jsonValidator->isValid()) {
            foreach ($jsonValidator->getErrors() as $error) {
                $message = $this->normalizeErrorMessage($error['message']);
                throw new HttpException(sprintf("[%s] %s", $error['property'], $message), 400);
            }
        }

        return true;
    }

    private function getValueByPath($parts, $object, $path, $optional, $default)
    {
        $first = array_shift($parts);

        if (is_object($object)) {
            if (!property_exists($object, $first)) {
                if (!$optional) {
                    throw new Exception(sprintf('Request parameter does not exist: %s', $path));
                }

                return $default;
            }

            $object = $object->$first;
        }
        else if (is_array($object)) {
            if (!array_key_exists($first, $object)) {
                if (!$optional) {
                    throw new Exception(sprintf('Request parameter does not exist: %s', $path));
                }

                return $default;
            }

            $object = $object[$first];
        }

        if (!count($parts)) {
            return $object;
        }

        return $this->getValueByPath($parts, $object, $path, $optional, $default);
    }

    private function normalizeErrorMessage($message)
    {
        if (strpos($message, 'Does not match the regex pattern') !== false) {
            return 'Has invalid format';
        }

        return $message;
    }

    private function makeTargetSchemaObject($schemaString, $schemaName)
    {
        $commonRequired = $this->getSchemaByName('COMMON_ARGUMENTS_REQUIRED');

        $commonProperties = @json_decode($this->getSchemaByName('COMMON_ARGUMENTS_PROPERTIES'));
        if ($commonProperties === null) {
            throw new Exception('Cannot decode JSON schema: COMMON_ARGUMENTS_PROPERTIES');
        }

        $commonDefinitions = @json_decode($this->getSchemaByName('COMMON_DEFINITIONS'));
        if ($commonDefinitions === null) {
            throw new Exception('Cannot decode JSON schema: COMMON_DEFINITIONS');
        }

        $targetSchemaObject = @json_decode($schemaString);
        if ($targetSchemaObject === null) {
            throw new Exception(sprintf('Cannot decode JSON schema: %s', $schemaName));
        }

        $commonProperties = (array)$commonProperties;
        if (!property_exists($targetSchemaObject, 'properties')) {
            $targetSchemaObject->properties = new \stdClass();
        }

        foreach ($commonProperties as $property=>$definition) {
            $targetSchemaObject->properties->$property = $definition;
        }

        $commonDefinitions = (array)$commonDefinitions;
        if (!property_exists($targetSchemaObject, 'definitions')) {
            $targetSchemaObject->definitions = new \stdClass();
        }

        foreach ($commonDefinitions as $definition=>$params) {
            $targetSchemaObject->definitions->$definition = $params;
        }

        if (!property_exists($targetSchemaObject, 'required')) {
            $targetSchemaObject->definitions = [];
        }

        foreach ($commonRequired as $property) {
            $targetSchemaObject->required[] = $property;
        }

        return $targetSchemaObject;
    }

    private function getSchemaByName($schemaName)
    {
        $constantName = 'PhpDeployer\Util\JsonSchemaStrings::'.$schemaName;

        if (!defined($constantName))
        {
            throw new Exception(sprintf('Unknown JSON schema: %s', $schemaName));
        }

        return constant($constantName);
    }
}