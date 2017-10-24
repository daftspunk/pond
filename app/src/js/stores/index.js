import Vuex from 'vuex'
import projects from './projects'

var store = null

export default {
    makeStore: () => store = new Vuex.Store({
        modules: {
            projects: projects
        }
    }),
    getStore: () => store,
    getVuex: () => Vuex
}