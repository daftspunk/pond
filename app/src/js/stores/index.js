const Vuex = require('vuex')

var store = null

module.exports = {
    makeStore: () => store = new Vuex.Store({
        modules: {
            projects: require('./projects')
        }
    }),
    getStore: () => store,
    getVuex: () => Vuex
}