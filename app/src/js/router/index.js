const VueRouter = require('vue-router')
const Routes = require('./routes')

module.exports = {
    getVueRouter: () => VueRouter,
    makeRouter: () => new VueRouter({
        routes: Routes
    })
}