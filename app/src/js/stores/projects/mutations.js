const LogState = require('../../projects/log-state')
const environmentStatus = require('../../environments/status')

function findProjectById(state, id) {
    return state.list.find(project => project.id == id)
}

function createProjectRuntimeState(project) {
    Object.assign(project, {
        runtime: {
            status: environmentStatus.OFFLINE,
            serverLog: null,
            applicationLog: null,
            phpErrorLog: null
        }
    })
}

module.exports = {
    // Important TODO: the project deletion mutation
    // must trigger deletion of the environment object,
    // if is initialized in the memory. This should
    // remove all event listeners inside the environment
    // and nullify internal references.

    SET_PROJECTS (state, payload) {
        state.loading = false

        payload.projects.forEach(project => 
            createProjectRuntimeState(project)
        )

        state.list = payload.projects
    },
    SET_SELECTED_PROJECT (state, payload) {
        if (!payload.project.runtime.serverLog) {
            payload.project.runtime.serverLog = new LogState()
            payload.project.runtime.applicationLog = new LogState()
            payload.project.runtime.phpErrorLog = new LogState()
        }

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
    },
    ADD_PROJECT (state, payload)
    {
        var project = payload.project

        createProjectRuntimeState(project)
        state.list.push(project)
    }
}