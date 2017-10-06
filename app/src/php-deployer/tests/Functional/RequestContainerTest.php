<?php namespace Tests\Functional;

use PhpDeployer\Util\RequestContainer;
use Exception;

class RequestContainerTest extends BaseCase
{
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

        $this->assertEquals(10, $container->getValue('topLevelInt'));
        $this->assertInternalType('array', $container->getValue('topLevelArray'));
        $this->assertCount(3, $container->getValue('topLevelArray'));
        $this->assertContains(2, $container->getValue('topLevelArray'));
        $this->assertEquals(3, $container->getValue('topLevelArray.2'));

        $this->assertInternalType('object', $container->getValue('topLevelObject'));
        $this->assertEquals(10, $container->getValue('topLevelObject')->propertyInt);
        $this->assertEquals("15", $container->getValue('topLevelObject')->propertyString);
        $this->assertInternalType('array', $container->getValue('topLevelObject')->propertyArray);
        $this->assertInternalType('object', $container->getValue('topLevelObject')->propertyObject);
        $this->assertEquals('44', $container->getValue('topLevelObject.propertyObject.propertyInt'));
        $this->assertEquals('7', $container->getValue('topLevelObject.propertyArray.1.id'));
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
            $this->assertEquals(10, $container->getValue('invalidTopLevel'));
            $this->assertFalse(true, 'Must fail');
        } catch (Exception $ex) {
            $this->assertTrue(true);
        }

        try {
            $this->assertEquals(10, $container->getValue('topLevelObject.invalid'));
            $this->assertFalse(true, 'Must fail');
        } catch (Exception $ex) {
            $this->assertTrue(true);
        }

        try {
            $this->assertEquals(10, $container->getValue('topLevelObject.propertyArray.10'));
            $this->assertFalse(true, 'Must fail');
        } catch (Exception $ex) {
            $this->assertTrue(true);
        }
    }



    // Todo - test property, array index does not exist
    


    // TODO - dependent testGetBasicParameters
}