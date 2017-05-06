function findProjectById(state, id) {
    for (var clientIndex in state.clients) {
        var client = state.clients[clientIndex]

        var project = client.projects.find((project) => {
            return project.id == id
        })

        if (project) {
            return project
        }
    }

    return null
}

module.exports = {
    // Important TODO: the project deletion mutation
    // must trigger deletion of the environment object,
    // if is initialized in the memory. This should
    // remove all event listeners inside the environment
    // and nullify internal references.


    SET_SELECTED_CLIENT_AND_PROJECT (state, payload) {
        state.selectedProject = payload.project
        state.selectedClient = payload.client
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