const Bootstrap = require('bootstrap')

require('../stylesheets/main.less')

import Vue from 'vue'
import App from './components/app.vue'
import appRouter from './router'
import i18nProvider from './i18n'
import store from './stores'
import linksWatcher from './html-utils/links-watcher'

Vue.use(appRouter.getVueRouter())
Vue.use(i18nProvider.getVueI18n())
Vue.use(store.getVuex())

const i18n = i18nProvider.makeI18n() // Use i18n.locale = ... to change locale in runtime

new Vue({
    router: appRouter.makeRouter(),
    i18n: i18n,
    el: '#app',
    store: store.makeStore(),
    render: h => h(App)
})

Vue.config.errorHandler = function (error, vm, info) {
    alert(error)

    // Don't throw in the production mode
    throw error
}

window.onerror = function(error) {
    alert(error)
}
