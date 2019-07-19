import {assert} from 'chai'
import DeployTest from '../src/js/remote/deployment/deploy-test.js'

// Imports that are done through nw.require() in Pond code
// must be done explicitly in tests.
import ssh2 from 'ssh2'

// describe('New deployment', function() {
//     describe('No errors', function() {
//         it('Main page content', async () => {
//             var dp = new DeployTest()
//             const result = await dp.deploy()
//             assert.include(result, 'Stream :: close');
//         })
//     })
// })