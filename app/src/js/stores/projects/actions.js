const Environments = require('../../environments')
const EnvironmentStatus = require('../../environments/status')

module.exports = {
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
            project,
            status: EnvironmentStatus.STARTING
        })

        Environments.get(project).start()
            .then(() => {
                context.commit('SET_PROJECT_STATUS', {
                    project,
                    status: EnvironmentStatus.ONLINE
                })
            })
            .catch(() => {
                context.commit('SET_PROJECT_STATUS', {
                    project,
                    status: EnvironmentStatus.OFFLINE
                })
            })
    }
}