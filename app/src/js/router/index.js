var VueRouter = require('vue-router')
var Routes = require('./routes')

module.exports = {
    vueRouter: VueRouter,
    makeRouter: () => new VueRouter({
        routes: Routes
    })
}