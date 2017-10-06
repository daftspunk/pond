<?php namespace PhpDeployer\Util;

// We keep this in a PHP file to simplify packaging

class JsonSchemaStrings
{
    // Ideally we should use definitions and references
    // to define common arguments as a requirement,
    // but the validator fails to test required properties
    // in this case, although the schema is valid 
    // (tested with an online tool). Falling back to a simple
    // schema merging here.

    const COMMON_ARGUMENT_PROPERTIES = '{
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
    }';

    const COMMON_ARGUMENT_REQUIRED = [
        'privateKeyPath',
        'publicKeyPath',
        'ip',
        'user'
    ];

    const COMMON_ARGUMENTS = '{
        "type": "object",
        "properties": {},
        "required": []
    }';
}