const Vuex = require('vuex')

module.exports = {
    makeStore: () => new Vuex.Store({
        modules: {
            projects: require('./projects')
        }
    }),
    getVuex: () => Vuex
}