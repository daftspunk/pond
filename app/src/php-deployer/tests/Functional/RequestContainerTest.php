<?php namespace Tests\Functional;

use PhpDeployer\Util\RequestContainer;
use Exception;

class RequestContainerTest extends BaseCase
{
    private $customSchema = '{
        "type": "object",
        "properties": {
            "identifier": {
                "type": "string"
            }
        },
        "required": ["identifier"]
    }';

    public function testValidateBasicParameters()
    {
        $container = new RequestContainer('{
            "privateKeyPath": "/path/to/private-key",
            "publicKeyPath": "/path/to/public-key",
            "ip": "192.168.0.1",
            "user": "deploy"
        }');

        $this->assertTrue($container->validate('COMMON_ARGUMENTS'));
    }

    /**
     * @expectedException        PhpDeployer\Exceptions\Http
     * @expectedExceptionMessage privateKeyPath is required
     */
    public function testValidateNoRequiedBasicParameter()
    {
        $container = new RequestContainer('{}');
        $container->validate('COMMON_ARGUMENTS');
    }

    /**
     * @expectedException        PhpDeployer\Exceptions\Http
     * @expectedExceptionMessage invalid format
     */
    public function testValidateInvalidUserName()
    {
        $container = new RequestContainer('{
            "privateKeyPath": "/path/to/private-key",
            "publicKeyPath": "/path/to/public-key",
            "ip": "192.168.0.1",
            "user": "12....3"
        }');

        $this->assertTrue($container->validate('COMMON_ARGUMENTS'));
    }

    public function testGetValues()
    {
        $container = new RequestContainer('{
            "topLevelInt": 10,
            "topLevelArray": [1, 2, 3],
            "topLevelObject": {
                "propertyInt": 10,
                "propertyString": "15",
                "propertyArray": [1, {"id": 7}, 3],
                "propertyObject": {
                    "propertyInt": 44
                }
            }
        }');

        $this->assertEquals(10, $container->get('topLevelInt'));
        $this->assertInternalType('array', $container->get('topLevelArray'));
        $this->assertCount(3, $container->get('topLevelArray'));
        $this->assertContains(2, $container->get('topLevelArray'));
        $this->assertEquals(3, $container->get('topLevelArray.2'));

        $this->assertInternalType('object', $container->get('topLevelObject'));
        $this->assertEquals(10, $container->get('topLevelObject')->propertyInt);
        $this->assertEquals("15", $container->get('topLevelObject')->propertyString);
        $this->assertInternalType('array', $container->get('topLevelObject')->propertyArray);
        $this->assertInternalType('object', $container->get('topLevelObject')->propertyObject);
        $this->assertEquals('44', $container->get('topLevelObject.propertyObject.propertyInt'));
        $this->assertEquals('7', $container->get('topLevelObject.propertyArray.1.id'));
    }

    public function testGetDefaultValue()
    {
        $container = new RequestContainer('{
            "topLevelInt": 10
        }');

        $this->assertEquals(10, $container->get('topLevelInt'));
        $this->assertNull($container->get('noProperty', true));
        $this->assertEquals('value', $container->get('noProperty', true, 'value'));
    }

    public function testInvalidProperties()
    {
        $container = new RequestContainer('{
            "topLevelInt": 10,
            "topLevelArray": [1, 2, 3],
            "topLevelObject": {
                "propertyInt": 10,
                "propertyString": "15",
                "propertyArray": [1, {"id": 7}, 3],
                "propertyObject": {
                    "propertyInt": 44
                }
            }
        }');

        try {
            $this->assertEquals(10, $container->get('invalidTopLevel'));
            $this->assertFalse(true, 'Must fail');
        } catch (Exception $ex) {
            $this->assertContains('parameter does not exist', $ex->getMessage());
        }

        try {
            $this->assertEquals(10, $container->get('topLevelObject.invalid'));
            $this->assertFalse(true, 'Must fail');
        } catch (Exception $ex) {
            $this->assertContains('parameter does not exist', $ex->getMessage());
        }

        try {
            $this->assertEquals(10, $container->get('topLevelObject.propertyArray.10'));
            $this->assertFalse(true, 'Must fail');
        } catch (Exception $ex) {
            $this->assertContains('parameter does not exist', $ex->getMessage());
        }
    }

    public function testCustomSchemaNoCustomProperty()
    {
        $container = new RequestContainer('{
            "privateKeyPath": "/path/to/private-key",
            "publicKeyPath": "/path/to/public-key",
            "ip": "192.168.0.1",
            "user": "deploy"
        }');

        try {
            $container->validateCustomSchema($this->customSchema, 'custom');
            $this->assertFalse(true, 'Must fail');
        }
        catch (Exception $ex) {
            $this->assertContains('identifier is required', $ex->getMessage());
        }

        $this->assertTrue($container->validate('COMMON_ARGUMENTS'));
    }

    public function testCustomSchemaNoCommonProperty()
    {
        $container = new RequestContainer('{
            "privateKeyPath": "/path/to/private-key",
            "publicKeyPath": "/path/to/public-key",
            "ip": "192.168.0.1",
            "identifier": "some"
        }');

        try {
            $container->validateCustomSchema($this->customSchema, 'custom');
            $this->assertFalse(true, 'Must fail');
        }
        catch (Exception $ex) {
            $this->assertContains('user is required', $ex->getMessage());
        }
    }

    public function testCustomSchemaValid()
    {
        $container = new RequestContainer('{
            "privateKeyPath": "/path/to/private-key",
            "publicKeyPath": "/path/to/public-key",
            "ip": "192.168.0.1",
            "user": "deploy",
            "identifier": "some"
        }');

        $this->assertTrue($container->validateCustomSchema($this->customSchema, 'custom'));
    }

    /**
     * @expectedException        PhpDeployer\Exceptions\Http
     * @expectedExceptionMessage params is required
     */
    public function testDeploymentRequiredArgumentsNoParams()
    {
        $container = new RequestContainer('{
            "privateKeyPath": "/path/to/private-key",
            "publicKeyPath": "/path/to/public-key",
            "ip": "192.168.0.1",
            "user": "deploy"
        }');

        $container->validate('DEPLOYMENT_REQUIRED_ARGUMENTS');
    }

    /**
     * @expectedException        PhpDeployer\Exceptions\Http
     * @expectedExceptionMessage update is required
     */
    public function testDeploymentRequiredArgumentsNoUpdate()
    {
        $container = new RequestContainer('{
            "privateKeyPath": "/path/to/private-key",
            "publicKeyPath": "/path/to/public-key",
            "ip": "192.168.0.1",
            "user": "deploy",
            "params": {

            }
        }');

        $container->validate('DEPLOYMENT_REQUIRED_ARGUMENTS');
    }

    /**
     * @expectedException        PhpDeployer\Exceptions\Http
     * @expectedExceptionMessage boolean is required
     */
    public function testDeploymentRequiredArgumentsUpdateNotBoolean()
    {
        $container = new RequestContainer('{
            "privateKeyPath": "/path/to/private-key",
            "publicKeyPath": "/path/to/public-key",
            "ip": "192.168.0.1",
            "user": "deploy",
            "params": {
                "update": "string",
                "projectDirectoryName": "string",
                "environmentDirectoryName": "string",
                "localProjectPath": "string",
                "permissions": "string"
            }
        }');

        $container->validate('DEPLOYMENT_REQUIRED_ARGUMENTS');
    }

    /**
     * @expectedException        PhpDeployer\Exceptions\Http
     * @expectedExceptionMessage [params.projectDirectoryName] Has invalid format
     */
    public function testDeploymentRequiredArgumentsDirectoryNameInvalidFormat()
    {
        $container = new RequestContainer('{
            "privateKeyPath": "/path/to/private-key",
            "publicKeyPath": "/path/to/public-key",
            "ip": "192.168.0.1",
            "user": "deploy",
            "params": {
                "update": true,
                "projectDirectoryName": "@",
                "environmentDirectoryName": "string",
                "localProjectPath": "string",
                "permissions": {
                    "directory": "1234",
                    "file": "777",
                    "config": "777"
                }
            }
        }');

        $container->validate('DEPLOYMENT_REQUIRED_ARGUMENTS');
    }

    public function testDeploymentRequiredArgumentsValidDirectoryName()
    {
        $container = new RequestContainer('{
            "privateKeyPath": "/path/to/private-key",
            "publicKeyPath": "/path/to/public-key",
            "ip": "192.168.0.1",
            "user": "deploy",
            "params": {
                "update": true,
                "projectDirectoryName": "project",
                "environmentDirectoryName": "environment",
                "localProjectPath": "string",
                "permissions": {
                    "directory": "777",
                    "file": "777",
                    "config": "777"
                }
            }
        }');

        $this->assertTrue($container->validate('DEPLOYMENT_REQUIRED_ARGUMENTS'));
    }

    /**
     * @expectedException        PhpDeployer\Exceptions\Http
     * @expectedExceptionMessage directory is required
     */
    public function testDeploymentRequiredArgumentsNoDirectoryPermissions()
    {
        $container = new RequestContainer('{
            "privateKeyPath": "/path/to/private-key",
            "publicKeyPath": "/path/to/public-key",
            "ip": "192.168.0.1",
            "user": "deploy",
            "params": {
                "update": true,
                "projectDirectoryName": "string",
                "environmentDirectoryName": "string",
                "localProjectPath": "string",
                "permissions": {
                    "file": "777",
                    "config": "777"
                }
            }
        }');

        $container->validate('DEPLOYMENT_REQUIRED_ARGUMENTS');
    }

    /**
     * @expectedException        PhpDeployer\Exceptions\Http
     * @expectedExceptionMessage [params.permissions.directory] Has invalid format
     */
    public function testDeploymentRequiredArgumentsInvalidDirectoryPermissions()
    {
        $container = new RequestContainer('{
            "privateKeyPath": "/path/to/private-key",
            "publicKeyPath": "/path/to/public-key",
            "ip": "192.168.0.1",
            "user": "deploy",
            "params": {
                "update": true,
                "projectDirectoryName": "string",
                "environmentDirectoryName": "string",
                "localProjectPath": "string",
                "permissions": {
                    "directory": "1234",
                    "file": "777",
                    "config": "777"
                }
            }
        }');

        $container->validate('DEPLOYMENT_REQUIRED_ARGUMENTS');
    }

    /**
     * @expectedException        PhpDeployer\Exceptions\Http
     * @expectedExceptionMessage at most 50 characters
     */
    public function testDeploymentRequiredArgumentsBuildTagTooLong()
    {
        $container = new RequestContainer('{
            "privateKeyPath": "/path/to/private-key",
            "publicKeyPath": "/path/to/public-key",
            "ip": "192.168.0.1",
            "user": "deploy",
            "params": {
                "update": true,
                "projectDirectoryName": "string",
                "environmentDirectoryName": "string",
                "localProjectPath": "string",
                "permissions": {
                    "directory": "777",
                    "file": "777",
                    "config": "777"
                },
                "buildTag": "1234567890123456789012345678901234567890123456789012345678901234567890"
            }
        }');

        $container->validate('DEPLOYMENT_REQUIRED_ARGUMENTS');
    }

    /**
     * @expectedException        PhpDeployer\Exceptions\Http
     * @expectedExceptionMessage [params.updateComponents.plugins] String value found
     */
    public function testDeploymentUpdateComponentsInvalidPlugins()
    {
        $container = new RequestContainer('{
            "privateKeyPath": "/path/to/private-key",
            "publicKeyPath": "/path/to/public-key",
            "ip": "192.168.0.1",
            "user": "deploy",
            "params": {
                "updateComponents": {
                    "core": true,
                    "plugins": "none",
                    "themes": ["website-final"],
                    "media": true
                }
            }
        }');

        $container->validate('DEPLOYMENT_UPDATE_COMPONENTS');
    }

    /**
     * @expectedException        PhpDeployer\Exceptions\Http
     * @expectedExceptionMessage [params.updateComponents.themes[0]] Has invalid format
     */
    public function testDeploymentUpdateComponentsInvalidTheme()
    {
        $container = new RequestContainer('{
            "privateKeyPath": "/path/to/private-key",
            "publicKeyPath": "/path/to/public-key",
            "ip": "192.168.0.1",
            "user": "deploy",
            "params": {
                "updateComponents": {
                    "core": true,
                    "plugins": false,
                    "themes": ["website@final"],
                    "media": true
                }
            }
        }');

        $container->validate('DEPLOYMENT_UPDATE_COMPONENTS');
    }

    /**
     * @expectedException        PhpDeployer\Exceptions\Http
     * @expectedExceptionMessage file is required
     */
    public function testDeploymentConfigTemplatesNoFile()
    {
        $container = new RequestContainer('{
            "privateKeyPath": "/path/to/private-key",
            "publicKeyPath": "/path/to/public-key",
            "ip": "192.168.0.1",
            "user": "deploy",
            "params": {
                "configTemplates": [
                    {
                        "template": "some string",
                        "vars": []
                    }
                ]
            }
        }');

        $container->validate('DEPLOYMENT_CONFIG_TEMPLATES');
    }

    /**
     * @expectedException        PhpDeployer\Exceptions\Http
     * @expectedExceptionMessage Has invalid format
     */
    public function testDeploymentConfigTemplatesFileInvalid()
    {
        $container = new RequestContainer('{
            "privateKeyPath": "/path/to/private-key",
            "publicKeyPath": "/path/to/public-key",
            "ip": "192.168.0.1",
            "user": "deploy",
            "params": {
                "configTemplates": [
                    {
                        "file": "some",
                        "template": "some string",
                        "vars": []
                    }
                ]
            }
        }');

        $container->validate('DEPLOYMENT_CONFIG_TEMPLATES');
    }

    /**
     * @expectedException        PhpDeployer\Exceptions\Http
     * @expectedExceptionMessage name is required
     */
    public function testDeploymentConfigTemplatesVarsNoName()
    {
        $container = new RequestContainer('{
            "privateKeyPath": "/path/to/private-key",
            "publicKeyPath": "/path/to/public-key",
            "ip": "192.168.0.1",
            "user": "deploy",
            "params": {
                "configTemplates": [
                    {
                        "file": "some.php",
                        "template": "some string",
                        "vars": [
                            {
                                "value": 12
                            }
                        ]
                    }
                ]
            }
        }');

        $container->validate('DEPLOYMENT_CONFIG_TEMPLATES');
    }

    /**
     * @expectedException        PhpDeployer\Exceptions\Http
     * @expectedExceptionMessage engine is required
     */
    public function testDeploymentDatabaseInitParametersNoEngine()
    {
        $container = new RequestContainer('{
            "privateKeyPath": "/path/to/private-key",
            "publicKeyPath": "/path/to/public-key",
            "ip": "192.168.0.1",
            "user": "deploy",
            "params": {
                "databaseInit": {
                    "initDatabase": true
                }
            }
        }');

        $container->validate('DEPLOYMENT_DATABASE_INIT_PARAMETERS');
    }

    /**
     * @expectedException        PhpDeployer\Exceptions\Http
     * @expectedExceptionMessage Does not have a value in the enumeration
     */
    public function testDeploymentDatabaseInitParametersInvalidEngine()
    {
        $container = new RequestContainer('{
            "privateKeyPath": "/path/to/private-key",
            "publicKeyPath": "/path/to/public-key",
            "ip": "192.168.0.1",
            "user": "deploy",
            "params": {
                "databaseInit": {
                    "initDatabase": true,
                    "engine": "oracle",
                    "dump": "string",
                    "connection": {
                        "host": "127.0.0.1",
                        "user": "deploy",
                        "password": "1234",
                        "port": 123,
                        "name": "database"
                    }
                }
            }
        }');

        $container->validate('DEPLOYMENT_DATABASE_INIT_PARAMETERS');
    }

    /**
     * @expectedException        PhpDeployer\Exceptions\Http
     * @expectedExceptionMessage host is required
     */
    public function testDeploymentDatabaseInitParametersNoHost()
    {
        $container = new RequestContainer('{
            "privateKeyPath": "/path/to/private-key",
            "publicKeyPath": "/path/to/public-key",
            "ip": "192.168.0.1",
            "user": "deploy",
            "params": {
                "databaseInit": {
                    "initDatabase": true,
                    "dump": "dump-string",
                    "engine": "mysql",
                    "connection": {
                        "user": "deploy",
                        "password": "1234",
                        "port": 123,
                        "name": "database"
                    }
                }
            }
        }');

        $container->validate('DEPLOYMENT_DATABASE_INIT_PARAMETERS');
    }

    public function testDeploymentDatabaseInitParametersValid()
    {
        $container = new RequestContainer('{
            "privateKeyPath": "/path/to/private-key",
            "publicKeyPath": "/path/to/public-key",
            "ip": "192.168.0.1",
            "user": "deploy",
            "params": {
                "databaseInit": {
                    "initDatabase": true,
                    "dump": "dump-string",
                    "engine": "mysql",
                    "connection": {
                        "host": "127.0.0.1",
                        "user": "deploy",
                        "password": "1234",
                        "port": 123,
                        "name": "database"
                    }
                }
            }
        }');

        $this->assertTrue($container->validate('DEPLOYMENT_DATABASE_INIT_PARAMETERS'));
    }

    /**
     * @expectedException        PhpDeployer\Exceptions\Http
     * @expectedExceptionMessage [params.projectDirectoryName] Has invalid format
     */
    public function testConfigurationDirectoryNameInvalidFormat()
    {
        $container = new RequestContainer('{
            "privateKeyPath": "/path/to/private-key",
            "publicKeyPath": "/path/to/public-key",
            "ip": "192.168.0.1",
            "user": "deploy",
            "params": {
                "update": true,
                "projectDirectoryName": "@",
                "environmentDirectoryName": "string",
                "localProjectPath": "string",
                "permissions": {
                    "directory": "123",
                    "file": "777",
                    "config": "777"
                },
                "configTemplates": [
                    {
                        "file": "some.php",
                        "template": "some string",
                        "vars": [
                            {
                                "value": 12
                            }
                        ]
                    }
                ]
            }
        }');

        $container->validate('CONFIGURATION_REQUIRED_ARGUMENTS');
    }

    public function testConfigurationValid()
    {
        $container = new RequestContainer('{
            "privateKeyPath": "/path/to/private-key",
            "publicKeyPath": "/path/to/public-key",
            "ip": "192.168.0.1",
            "user": "deploy",
            "params": {
                "update": true,
                "projectDirectoryName": "project",
                "environmentDirectoryName": "environment",
                "localProjectPath": "string",
                "permissions": {
                    "directory": "123",
                    "file": "777",
                    "config": "777"
                },
                "configTemplates": [
                    {
                        "file": "some.php",
                        "template": "some string",
                        "vars": [
                            {
                                "value": "12",
                                "name": "name"
                            }
                        ]
                    }
                ]
            }
        }');

        $this->assertTrue($container->validate('CONFIGURATION_REQUIRED_ARGUMENTS'));
    }

    public function testConfigurationNoTemplatesValid()
    {
        $container = new RequestContainer('{
            "privateKeyPath": "/path/to/private-key",
            "publicKeyPath": "/path/to/public-key",
            "ip": "192.168.0.1",
            "user": "deploy",
            "params": {
                "update": true,
                "projectDirectoryName": "project",
                "environmentDirectoryName": "environment",
                "localProjectPath": "string",
                "permissions": {
                    "directory": "123",
                    "file": "777",
                    "config": "777"
                },
                "configTemplates": []
            }
        }');

        $this->assertTrue($container->validate('CONFIGURATION_REQUIRED_ARGUMENTS'));
    }
    /**
     * @expectedException        PhpDeployer\Exceptions\Http
     * @expectedExceptionMessage activate is required
     */
    public function testSwapNoActivateValue()
    {
        $container = new RequestContainer('{
            "privateKeyPath": "/path/to/private-key",
            "publicKeyPath": "/path/to/public-key",
            "ip": "192.168.0.1",
            "user": "deploy",
            "params": {
                "projectDirectoryName": "directory",
                "environmentDirectoryName": "string"
            }
        }');

        $container->validate('SWAP_REQUIRED_ARGUMENTS');
    }

    /**
     * @expectedException        PhpDeployer\Exceptions\Http
     * @expectedExceptionMessage value in the enumeration ["blue","green"]
     */
    public function testSwapActivateNotBlueGreenValue()
    {
        $container = new RequestContainer('{
            "privateKeyPath": "/path/to/private-key",
            "publicKeyPath": "/path/to/public-key",
            "ip": "192.168.0.1",
            "user": "deploy",
            "params": {
                "projectDirectoryName": "directory",
                "environmentDirectoryName": "string",
                "activate": "yellow"
            }
        }');

        $container->validate('SWAP_REQUIRED_ARGUMENTS');
    }
    
}