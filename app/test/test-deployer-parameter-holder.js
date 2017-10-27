import {assert} from 'chai'
import ParameterHolder from '../src/js/remote/deployment/operations/parameter-holder.js'

describe('Deployer operation parameter holder', _ => {
    it('Basic parameters', done => {
        var holder = new ParameterHolder({
            privateKeyString: 'key-string',
            publicKeyString: 'key-string',
            ip: '192.168.0.1',
            user: 'deploy'
        })

        assert.isTrue(holder.validate('COMMON_ARGUMENTS'))
        done()
    })

    it('No requied basic parameter', done => {
        var holder = new ParameterHolder({})
        assert.throws(holder.validate.bind(holder, 'COMMON_ARGUMENTS'), Error, `required property 'privateKeyString'`)
        done()
    })

    it('Invalid user name', done => {
        var holder = new ParameterHolder({
            privateKeyString: 'key-string',
            publicKeyString: 'key-string',
            ip: '192.168.0.1',
            user: '12....3'
        })

        assert.throws(holder.validate.bind(holder, 'COMMON_ARGUMENTS'), Error, `invalid format`)
        done()
    })

    it('Get values', done => {
        var holder = new ParameterHolder({
            topLevelInt: 10,
            topLevelArray: [1, 2, 3],
            topLevelObject: {
                propertyInt: 10,
                propertyString: '15',
                propertyArray: [1, {id: 7}, 3],
                propertyObject: {
                    propertyInt: 44
                }
            }
        })

        assert.strictEqual(holder.get('topLevelInt'), 10)
        assert.typeOf(holder.get('topLevelArray'), 'array')
        assert.lengthOf(holder.get('topLevelArray'), 3)
        assert.include(holder.get('topLevelArray'), 2)
        assert.strictEqual(holder.get('topLevelArray.2'), 3)

        assert.typeOf(holder.get('topLevelObject'), 'object')
        assert.strictEqual(holder.get('topLevelObject').propertyInt, 10)
        assert.strictEqual(holder.get('topLevelObject').propertyString, '15')
        assert.typeOf(holder.get('topLevelObject').propertyArray, 'array')
        assert.typeOf(holder.get('topLevelObject').propertyObject, 'object')
        assert.strictEqual(holder.get('topLevelObject.propertyObject.propertyInt'), 44)
        assert.strictEqual(holder.get('topLevelObject.propertyArray.1.id'), 7)
        done()
    })

    it('Get default value', done => {
        var holder = new ParameterHolder({
            topLevelInt: 10
        })

        assert.strictEqual(holder.get('topLevelInt'), 10)
        assert.isNull(holder.get('noProperty', true))
        assert.strictEqual(holder.get('noProperty', true, 'value'), 'value')
        done()
    })

    it('Test invalid properties', done => {
        var holder = new ParameterHolder({
            topLevelInt: 10,
            topLevelArray: [1, 2, 3],
            topLevelObject: {
                propertyInt: 10,
                propertyString: '15',
                propertyArray: [1, {'id': 7}, 3],
                propertyObject: {
                    propertyInt: 44
                }
            }
        })

        assert.throws(holder.get.bind(holder, 'invalidTopLevel'), Error, `Parameter does not exist`)
        assert.throws(holder.get.bind(holder, 'topLevelObject.invalid'), Error, `Parameter does not exist`)
        assert.throws(holder.get.bind(holder, 'topLevelObject.propertyArray.10'), Error, `Parameter does not exist`)
        done()
    })

    it('No params in the deployment required arguments', done => {
        var holder = new ParameterHolder({
            privateKeyString: 'key-string',
            publicKeyString: 'key-string',
            ip: '192.168.0.1',
            user: 'deploy'
        })

        assert.throws(holder.validate.bind(holder, 'DEPLOYMENT_REQUIRED_ARGUMENTS'), Error, `required property 'params'`)
        done()
    })

    it('Invalid directory name', done => {
        var holder = new ParameterHolder({
            privateKeyString: 'key-string',
            publicKeyString: 'key-string',
            ip: '192.168.0.1',
            user: 'deploy',
            params: {
                update: true,
                projectDirectoryName: '@',
                environmentDirectoryName: 'string',
                localProjectPath: 'string',
                permissions: {
                    directory: '123',
                    file: '777',
                    config: '777'
                },
                scripts: []
            }
        })

        assert.throws(holder.validate.bind(holder, 'DEPLOYMENT_REQUIRED_ARGUMENTS'), Error, `params.projectDirectoryName: invalid format`)
        done()
    })

    it('Invalid directory permissions', done => {
        var holder = new ParameterHolder({
            privateKeyString: 'key-string',
            publicKeyString: 'key-string',
            ip: '192.168.0.1',
            user: 'deploy',
            params: {
                update: true,
                projectDirectoryName: 'string',
                environmentDirectoryName: 'string',
                localProjectPath: 'string',
                permissions: {
                    directory: '1234',
                    file: '777',
                    config: '777'
                },
                scripts: []
            }
        })

        assert.throws(holder.validate.bind(holder, 'DEPLOYMENT_REQUIRED_ARGUMENTS'), Error, `params.permissions.directory: invalid format`)
        done()
    })

    it('Build tag too long', done => {
        var holder = new ParameterHolder({
            privateKeyString: 'key-string',
            publicKeyString: 'key-string',
            ip: '192.168.0.1',
            user: 'deploy',
            params: {
                update: true,
                projectDirectoryName: 'string',
                environmentDirectoryName: 'string',
                localProjectPath: 'string',
                permissions: {
                    directory: '777',
                    file: '777',
                    config: '777'
                },
                buildTag: '1234567890123456789012345678901234567890123456789012345678901234567890',
                scripts: []
            }
        })

        assert.throws(holder.validate.bind(holder, 'DEPLOYMENT_REQUIRED_ARGUMENTS'), Error, `NOT be longer than 50 characters`)
        done()
    })

    it('Unknown deployment script type', done => {
        var holder = new ParameterHolder({
            privateKeyString: 'key-string',
            publicKeyString: 'key-string',
            ip: '192.168.0.1',
            user: 'deploy',
            params: {
                update: true,
                projectDirectoryName: 'string',
                environmentDirectoryName: 'string',
                localProjectPath: 'string',
                permissions: {
                    directory: '777',
                    file: '777',
                    config: '777'
                },
                buildTag: '123',
                scripts: [
                    {
                        type: 'some',
                        contents: 'string'
                    }
                ]
            }
        })

        assert.throws(holder.validate.bind(holder, 'DEPLOYMENT_REQUIRED_ARGUMENTS'), Error, `should be equal to one of the allowed values`)
        done()
    })

    it('Valid deployment required arguments', done => {
        var holder = new ParameterHolder({
            privateKeyString: 'key-string',
            publicKeyString: 'key-string',
            ip: '192.168.0.1',
            user: 'deploy',
            params: {
                update: true,
                projectDirectoryName: 'string',
                environmentDirectoryName: 'string',
                localProjectPath: 'string',
                permissions: {
                    directory: '777',
                    file: '777',
                    config: '777'
                },
                buildTag: '123',
                scripts: [
                    {
                        type: 'post-deployment',
                        contents: 'string'
                    }
                ]
            }
        })

        assert.isTrue(holder.validate('DEPLOYMENT_REQUIRED_ARGUMENTS'))
        done()
    })

    it('Deployment update components invalid plugins', done => {
        var holder = new ParameterHolder({
            privateKeyString: '/path/to/private-key',
            publicKeyString: '/path/to/public-key',
            ip: '192.168.0.1',
            user: 'deploy',
            params: {
                updateComponents: {
                    core: true,
                    plugins: 'none',
                    themes: ['website-final'],
                    media: true
                }
            }
        })

        assert.throws(holder.validate.bind(holder, 'DEPLOYMENT_UPDATE_COMPONENTS'), Error, `should be boolean`)
        done()
    })

    it('No configuration file name provided', done => {
        var holder = new ParameterHolder({
            privateKeyString: '/path/to/private-key',
            publicKeyString: '/path/to/public-key',
            ip: '192.168.0.1',
            user: 'deploy',
            params: {
                configTemplates: [
                    {
                        template: 'some string',
                        vars: []
                    }
                ]
            }
        })

        assert.throws(holder.validate.bind(holder, 'DEPLOYMENT_CONFIG_TEMPLATES'), Error, `should have required property 'file'`)
        done()
    })

    it('No engine in the database init parameters', done => {
        var holder = new ParameterHolder({
            privateKeyString: '/path/to/private-key',
            publicKeyString: '/path/to/public-key',
            ip: '192.168.0.1',
            user: 'deploy',
            params: {
                databaseInit: {
                    initDatabase: true
                }
            }
        })

        assert.throws(holder.validate.bind(holder, 'DEPLOYMENT_DATABASE_INIT_PARAMETERS'), Error, `should have required property 'engine'`)
        done()
    })

    it('Unsupported engine in the database init parameters', done => {
        var holder = new ParameterHolder({
            privateKeyString: '/path/to/private-key',
            publicKeyString: '/path/to/public-key',
            ip: '192.168.0.1',
            user: 'deploy',
            params: {
                databaseInit: {
                    initDatabase: true,
                    engine: 'oracle',
                    dump: 'string',
                    connection: {
                        host: '127.0.0.1',
                        user: 'deploy',
                        password: '1234',
                        port: 123,
                        name: 'database'
                    }
                }
            }
        })

        assert.throws(holder.validate.bind(holder, 'DEPLOYMENT_DATABASE_INIT_PARAMETERS'), Error, `should be equal to one of the allowed values`)
        done()
    })

    it('Valid database init parameters', done => {
        var holder = new ParameterHolder({
            privateKeyString: '/path/to/private-key',
            publicKeyString: '/path/to/public-key',
            ip: '192.168.0.1',
            user: 'deploy',
            params: {
                databaseInit: {
                    initDatabase: true,
                    engine: 'mysql',
                    dump: 'string',
                    connection: {
                        host: '127.0.0.1',
                        user: 'deploy',
                        password: '1234',
                        port: 123,
                        name: 'database'
                    }
                }
            }
        })

        assert.isTrue(holder.validate('DEPLOYMENT_DATABASE_INIT_PARAMETERS'))
        done()
    })


    it('Invalid directory name in the configuration operation parameters', done => {
        var holder = new ParameterHolder({
            privateKeyString: '/path/to/private-key',
            publicKeyString: '/path/to/public-key',
            ip: '192.168.0.1',
            user: 'deploy',
            params: {
                update: true,
                projectDirectoryName: '@',
                environmentDirectoryName: 'string',
                localProjectPath: 'string',
                permissions: {
                    directory: '123',
                    file: '777',
                    config: '77'
                },
                configTemplates: [
                    {
                        file: 'some.php',
                        template: 'some string',
                        vars: [
                            {
                                'value': 12
                            }
                        ]
                    }
                ]
            }
        })

        assert.throws(holder.validate.bind(holder, 'CONFIGURATION_REQUIRED_ARGUMENTS'), Error, `params.projectDirectoryName: invalid format`)
        done()
    })

    it('Valid configuration operation parameters', done => {
        var holder = new ParameterHolder({
            privateKeyString: '/path/to/private-key',
            publicKeyString: '/path/to/public-key',
            ip: '192.168.0.1',
            user: 'deploy',
            params: {
                update: true,
                projectDirectoryName: 'string',
                environmentDirectoryName: 'string',
                localProjectPath: 'string',
                permissions: {
                    directory: '777',
                    file: '777',
                    config: '777'
                },
                configTemplates: [
                    {
                        file: 'some.php',
                        template: 'some string',
                        vars: [
                            {
                                name: 'name',
                                value: '12'
                            }
                        ]
                    }
                ]
            }
        })

        assert.isTrue(holder.validate('CONFIGURATION_REQUIRED_ARGUMENTS'))
        done()
    })

    it('Swap no active value', done => {
        var holder = new ParameterHolder({
            privateKeyString: '/path/to/private-key',
            publicKeyString: '/path/to/public-key',
            ip: '192.168.0.1',
            user: 'deploy',
            params: {
                'projectDirectoryName': 'directory',
                'environmentDirectoryName': 'string'
            }
        })

        assert.throws(holder.validate.bind(holder, 'SWAP_REQUIRED_ARGUMENTS'), Error, `should have required property 'activate'`)
        done()
    })
    // testConfigurationDirectoryNameInvalidFormat

    // testDeploymentUpdateComponentsInvalidPlugins
})