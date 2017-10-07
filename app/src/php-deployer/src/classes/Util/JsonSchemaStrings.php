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

    const COMMON_ARGUMENTS_PROPERTIES = '{
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

    const COMMON_ARGUMENTS_REQUIRED = [
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

    const COMMON_DEFINITIONS = '{
        "booleanOrPathArray": {
            "oneOf": [
                {
                    "type": "boolean"
                },
                {
                    "type": "array",
                    "minItems": 1,
                    "items": {
                        "type": "string",
                        "pattern": "^[0-9a-z_\\\-]+/[0-9a-z_\\\-]+$"
                    },
                    "uniqueItems": true
                }
            ]
        },
        "booleanOrNameArray": {
            "oneOf": [
                {
                    "type": "boolean"
                },
                {
                    "type": "array",
                    "minItems": 1,
                    "items": {
                        "type": "string",
                        "pattern": "^[0-9a-z_\\\-]+$"
                    },
                    "uniqueItems": true
                }
            ]
        },
        "permissions": {
            "type": "object",
            "properties": {
                "directory": {
                    "type": "string",
                    "pattern": "^[0-9]{3}$"
                },
                "file": {
                    "type": "string",
                    "pattern": "^[0-9]{3}$"
                },
                "config": {
                    "type": "string",
                    "pattern": "^[0-9]{3}$"
                }
            },
            "required": [
                "directory",
                "file",
                "config"
            ]
        },
        "configTemplates": {
            "type": "array",
            "items": {
                "type": "object",
                "properties": {
                    "file": {
                        "type": "string",
                        "pattern": "^[0-9a-z_\\\-]+\\\.php$"
                    },
                    "template": {
                        "type": "string"
                    },
                    "vars": {
                        "type": "array",
                        "items": {
                            "type": "object",
                            "properties": {
                                "name": {
                                    "type": "string"
                                },
                                "value": {
                                    "type": "string"
                                }
                            },
                            "required": [
                                "name",
                                "value"
                            ]
                        }
                    }
                },
                "required": [
                    "file",
                    "template",
                    "vars"
                ]
            }
        }
    }';

    const DEPLOYMENT_REQUIRED_ARGUMENTS = '{
        "type": "object",
        "properties": {
            "params": {
                "type": "object",
                "properties": {
                    "update": {
                        "type": "boolean"
                    },
                    "projectDirectoryName": {
                        "type": "string",
                        "pattern": "^[0-9a-zA-Z\\\-_]+$"
                    },
                    "environmentDirectoryName": {
                        "type": "string",
                        "pattern": "^[0-9a-zA-Z\\\-_]+$"
                    },
                    "localProjectPath": {
                        "type": "string"
                    },
                    "permissions": {
                        "$ref": "#/definitions/permissions"
                    },
                    "buildTag": {
                        "type": "string",
                        "maxLength": 50
                    }
                },
                "required": [
                    "update",
                    "projectDirectoryName",
                    "environmentDirectoryName",
                    "localProjectPath",
                    "permissions"
                ]
            }
        },
        "required": [
            "params"
        ]
    }';

    const DEPLOYMENT_UPDATE_COMPONENTS = '{
        "type": "object",
        "properties": {
            "params": {
                "type": "object",
                "properties": {
                    "updateComponents": {
                        "type": "object",
                        "properties": {
                            "core": {
                                "type": "boolean"
                            },
                            "plugins": {
                                "$ref": "#/definitions/booleanOrPathArray"
                            },
                            "themes": {
                                "$ref": "#/definitions/booleanOrNameArray"
                            },
                            "media": {
                                "type": "boolean"
                            }
                        }
                    }
                },
                "required": [
                    "updateComponents"
                ]
            }
        },
        "required": [
            "params"
        ]
    }';

    const DEPLOYMENT_CONFIG_TEMPLATES = '{
        "type": "object",
        "properties": {
            "params": {
                "type": "object",
                "properties": {
                    "configTemplates": {
                        "$ref": "#/definitions/configTemplates"
                    }
                },
                "required": [
                    "configTemplates"
                ]
            }
        },
        "required": [
            "params"
        ]
    }';

    const DEPLOYMENT_DATABASE_INIT = '{
        "type": "object",
        "properties": {
            "params": {
                "type": "object",
                "properties": {
                    "databaseInit": {
                        "type": "object",
                        "properties": {
                            "initDatabase": {
                                "type": "boolean"
                            },
                            "engine": {
                                "type": {
                                    "enum": ["mysql"]
                                }
                            }
                        },
                        "required": [
                            "initDatabase",
                            "engine"
                        ]
                    }
                },
                "required": [
                    "databaseInit"
                ]
            }
        },
        "required": [
            "params"
        ]
    }';

    const DEPLOYMENT_DATABASE_INIT_PARAMETERS = '{
        "type": "object",
        "properties": {
            "params": {
                "type": "object",
                "properties": {
                    "databaseInit": {
                        "type": "object",
                        "properties": {
                            "dump": {
                                "type": "string"
                            },
                            "connection": {
                                "type": "object",
                                "properties": {
                                    "host": {
                                        "type": "string",
                                        "pattern": "^[0-9a-zA-Z_\\\-\\\.]+$"
                                    },
                                    "user": {
                                        "type": "string"
                                    },
                                    "password": {
                                        "type": "string"
                                    },
                                    "port": {
                                        "type": "integer"
                                    },
                                    "name": {
                                        "type": "string"
                                    }
                                },
                                "required": [
                                    "host",
                                    "user",
                                    "password",
                                    "port",
                                    "name"
                                ]
                            }
                        },
                        "required": [
                            "dump",
                            "connection"
                        ]
                    }
                },
                "required": [
                    "databaseInit"
                ]
            }
        },
        "required": [
            "params"
        ]
    }';
}