const environments = require('../../environments')
const environmentStatus = require('../../environments/status')
const projects = require('../../database/projects')

module.exports = {
    loadState (context, payload) {
        return projects.getManager().list().then((loadedProjects) => {
            context.commit('SET_PROJECTS', {
                projects: loadedProjects
            })
        })
    },
    setSelectedProject (context, payload) {
        context.commit('SET_SELECTED_PROJECT', payload)
    },
    toggleProjectStar (context, project) {
        context.commit('SET_STARRED', {
            project: project,
            starred: !project.starred
        })
    },
    startServer (context, project) {
        context.commit('SET_PROJECT_STATUS', {
            projectId: project._id,
            status: environmentStatus.STARTING
        })

        environments.get(project).start()
    },
    stopServer (context, project) {
        context.commit('SET_PROJECT_STATUS', {
            projectId: project._id,
            status: environmentStatus.STARTING
        })

        environments.get(project).stop()
    },
    setProjectStatus (context, payload) {
        context.commit('SET_PROJECT_STATUS', payload)
    },
    logServerEvent (context, payload) {
        context.commit('LOG_SERVER_EVENT', payload)
    },
    addProject (context, payload) {
        context.commit('ADD_PROJECT', payload)
    },
    initNewProjectState (context, payload) {
        context.commit('INIT_NEW_PROJECT_STATE', payload)
    }
}