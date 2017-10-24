import VueRouter from 'vue-router'
import Routes from './routes'

var router = null;

function makeRouter() {
    if (router === null) {
        router = new VueRouter({
            routes: Routes
        })
    }

    return router
}

export default {
    getVueRouter: () => VueRouter,
    makeRouter
}