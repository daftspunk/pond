module.exports = {
    SET_SELECTED_CLIENT_AND_PROJECT (state, payload) {
        state.selectedProject = payload.project
        state.selectedClient = payload.client
    },
    SET_STARRED (state, payload) {
        payload.project.starred = payload.starred
    },
    SET_PROJECT_STATUS (state, payload)
    {
        payload.project.runtime.status = payload.status
    }
}