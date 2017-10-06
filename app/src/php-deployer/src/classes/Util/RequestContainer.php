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
        $targetSchemaObject = $this->makeTargetSchemaObject($schemaName);

        $schemaStorage = new SchemaStorage();
        $schemaStorage->addSchema('file://pond', $targetSchemaObject);

        $constraintsFactory = new ConstraintsFactory($schemaStorage);

        $jsonValidator = new JsonSchemaValidator($constraintsFactory);
        $jsonValidator->validate($this->requestJsonObject, $targetSchemaObject);

        if (!$jsonValidator->isValid()) {
            foreach ($jsonValidator->getErrors() as $error) {
                $message = $this->normalizeErrorMessage($error['message']);
                throw new HttpException(sprintf("[%s] %s\n", $error['property'], $message), 400);
            }
        }

        return true;
    }

    public function getValue($path)
    {
        $parts = explode('.', $path);

        return $this->getValueByPath($parts, $this->requestJsonObject, $path);
    }

    private function getValueByPath($parts, $object, $path)
    {
        $first = array_shift($parts);

        if (is_object($object)) {
            if (!property_exists($object, $first)) {
                throw new Exception(sprintf('Request parameter does not exist: %s', $path));
            }

            $object = $object->$first;
        }
        else if (is_array($object)) {
            if (!array_key_exists($object, $first)) {
                throw new Exception(sprintf('Request parameter does not exist: %s', $path));
            }

            $object = $object[$first];
        }

        if (!count($parts)) {
            return $object;
        }

        return $this->getValueByPath($parts, $object, $path);
    }

    private function normalizeErrorMessage($message)
    {
        if (strpos($message, 'Does not match the regex pattern') !== false) {
            return 'Has invalid format';
        }

        return $message;
    }

    private function makeTargetSchemaObject($schemaName)
    {
        $commonRequired = $this->getSchemaByName('COMMON_ARGUMENT_REQUIRED');

        $commonProperties = @json_decode($this->getSchemaByName('COMMON_ARGUMENT_PROPERTIES'));
        if ($commonProperties === null) {
            throw new Exception('Cannot decode JSON schema: COMMON_ARGUMENT_PROPERTIES');
        }

        $targetSchemaObject = @json_decode($this->getSchemaByName($schemaName));
        if ($targetSchemaObject === null) {
            throw new Exception(sprintf('Cannot decode JSON schema: %s', $schemaName));
        }

        $commonProperties = (array)$commonProperties;
        foreach ($commonProperties as $property=>$definition) {
            $targetSchemaObject->properties->$property = $definition;
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