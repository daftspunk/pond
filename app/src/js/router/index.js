const VueRouter = require('vue-router')
const Routes = require('./routes')

var router = null;

function makeRouter() {
    if (router === null) {
        router = new VueRouter({
            routes: Routes
        })
    }

    return router
}

module.exports = {
    getVueRouter: () => VueRouter,
    makeRouter
} 