import ProjectsView from '../components/projects-view.vue'
import Settings from '../components/settings.vue'
import NewProject from '../components/new-project/index.vue'

export default [
    {
        path: '/',
        component: ProjectsView
    },
    {
        path: '/settings',
        component: Settings
    },
    {
        path: '/new-project',
        component: NewProject
    }
]