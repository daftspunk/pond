var $ = require('jquery');
window.$ = window.jQuery = $;
var Bootstrap = require('bootstrap')

var Vue = require('vue')
var App = require('./components/app.vue')
var AppRouter = require('./router')
var I18n = require('./i18n')

Vue.use(AppRouter.vueRouter)
Vue.use(I18n.vueI18n)

const i18n = I18n.makeI18n() // Use i18n.locale = ... to change locale in runtime

new Vue({
    router: AppRouter.makeRouter(),
    i18n: i18n,
    el: '#app',
    render: h => h(App)
})