const Environments = require('../../environments')
const EnvironmentStatus = require('../../environments/status')

const Clients = require('../../database/clients')

module.exports = {
    loadState (context, payload) {
        return Clients.getManager().listClientsWithProjects().then((clients) => {
            context.commit('SET_CLIENTS_AND_PROJECTS', {
                clients
            })
        })
    },
    setSelectedClientAndProject (context, payload) {
        context.commit('SET_SELECTED_CLIENT_AND_PROJECT', payload)
    },
    toggleProjectStar (context, project) {
        context.commit('SET_STARRED', {
            project: project,
            starred: !project.starred
        })
    },
    startServer (context, project) {
        context.commit('SET_PROJECT_STATUS', {
            projectId: project.id,
            status: EnvironmentStatus.STARTING
        })

        Environments.get(project).start()
    },
    stopServer (context, project) {
        context.commit('SET_PROJECT_STATUS', {
            projectId: project.id,
            status: EnvironmentStatus.STARTING
        })

        Environments.get(project).stop()
    },
    setProjectStatus (context, payload) {
        context.commit('SET_PROJECT_STATUS', payload)
    },
    logServerEvent (context, payload) {
        context.commit('LOG_SERVER_EVENT', payload)
    }
}