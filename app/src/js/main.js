// const $ = require('jquery');
// window.$ = window.jQuery = $;
const Bootstrap = require('bootstrap')

import Vue from 'vue'
import App from './components/app.vue'
import AppRouter from './router'
import I18n from './i18n'
import Store from './stores'
import LinksWatcher from './html-utils/links-watcher'

Vue.use(AppRouter.getVueRouter())
Vue.use(I18n.getVueI18n())
Vue.use(Store.getVuex())

const i18n = I18n.makeI18n() // Use i18n.locale = ... to change locale in runtime

new Vue({
    router: AppRouter.makeRouter(),
    i18n: i18n,
    store: Store.makeStore(),
    render: h => h(App)
}).mount('#app')

Vue.config.errorHandler = function (error, vm, info) {
    alert(error)

    // Don't throw in the production mode
    throw error
}

window.onerror = function(error) {
    alert(error)
}