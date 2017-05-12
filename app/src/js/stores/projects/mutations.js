function findProjectById(state, id) {
    return state.list.find(project => project.id == id)
}

module.exports = {
    // Important TODO: the project deletion mutation
    // must trigger deletion of the environment object,
    // if is initialized in the memory. This should
    // remove all event listeners inside the environment
    // and nullify internal references.

    SET_PROJECTS (state, payload) {
        state.loading = false
        state.list = payload.projects
    },
    SET_SELECTED_PROJECT (state, payload) {
        state.selectedProject = payload.project
    },
    SET_STARRED (state, payload) {
        payload.project.starred = payload.starred
    },
    SET_PROJECT_STATUS (state, payload)
    {
        const project = findProjectById(state, payload.projectId)

        if (project) {
            project.runtime.status = payload.status
        }
    },
    LOG_SERVER_EVENT (state, payload)
    {
        const project = findProjectById(state, payload.projectId)

        if (project) {
            project.runtime.serverLog.addLine(payload.message)
        }
    }
}