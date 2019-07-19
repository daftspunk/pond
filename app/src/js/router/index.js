import VueRouter from 'vue-router'
import routes from './routes'

var router = null;

function makeRouter() {
    if (router === null) {
        router = new VueRouter({
            routes
        })
    }

    return router
}

export default {
    getVueRouter: () => VueRouter,
    makeRouter
}