var Vue = require('vue')
var App = require('./components/app.vue')
var AppRouter = require('./router')

Vue.use(AppRouter.vueRouter)

new Vue({
    router: AppRouter.makeRouter(),
    el: '#app',
    render: h => h(App)
})