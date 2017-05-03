const $ = require('jquery');
window.$ = window.jQuery = $;
const Bootstrap = require('bootstrap')

const Vue = require('vue')
const App = require('./components/app.vue')
const AppRouter = require('./router')
const I18n = require('./i18n')
const Store = require('./stores')
const LinksWatcher = require('./html-utils/links-watcher')

Vue.use(AppRouter.getVueRouter())
Vue.use(I18n.getVueI18n())
Vue.use(Store.getVuex())

const i18n = I18n.makeI18n() // Use i18n.locale = ... to change locale in runtime

new Vue({
    router: AppRouter.makeRouter(),
    i18n: i18n,
    el: '#app',
    store: Store.makeStore(),
    render: h => h(App)
})

Vue.config.errorHandler = function (error, vm, info) {
    alert(error)
}

window.onerror = function(error) {
    alert(error)
}