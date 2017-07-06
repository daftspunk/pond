const LogState = require('../../projects/log-state')
const environmentStatus = require('../../environments/status')
const initializationState = require('../../environments/initialization-state')
const projectDefaults = require('./defaults')

function findProjectById(state, id) {
    return state.list.find(project => project._id == id)
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

function generateEncryptionKey() {
    var result = ''
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'

    for (var i = 1; i <= 32; i++) {
        result += chars.charAt(Math.floor(Math.random() * chars.length))
    }

    return result
}

module.exports = {
    // Important TODO: the project deletion mutation
    // must trigger deletion of the environment object,
    // if is initialized in the memory. This should
    // remove all event listeners inside the environment
    // and nullify internal references.

    SET_PROJECTS (state, payload) {
        payload.projects.forEach(project => 
            createProjectRuntimeState(project)
        )

        state.list = payload.projects
        setTimeout(() => {state.loading = false}, 500)
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
    SET_PROJECT_STATUS (state, payload) {
        const project = findProjectById(state, payload.projectId)

        if (project) {
            project.runtime.status = payload.status
        }
    },
    LOG_SERVER_EVENT (state, payload) {
        const project = findProjectById(state, payload.projectId)

        if (project) {
            project.runtime.serverLog.addLine(payload.message)
        }
    },
    ADD_PROJECT (state, payload) {
        var project = payload.project

        createProjectRuntimeState(project)
        state.list.push(project)
    },
    INIT_NEW_PROJECT_STATE (state, payload)
    {
        // All non-configuration parameters should be
        // defined in the `runtime` property. All parameters
        // except `runtime` are used as the project coniguration
        // and passed directly to the Configuration Agent.
        //
        state.newProject =  {
            name: '',
            environmentType: '',
            location: '',
            client: '',
            description: '',
            localPort: null,
            useAdvancedOptions: false,
            runtime: {
                initState: new initializationState.Tracker(),
            }
        }

        Object.assign(state.newProject, projectDefaults.advancedOptions)

        state.newProject.encryptionKey = generateEncryptionKey()

        if (payload && payload.isDemo) {
            state.newProject.name = 'October CMS Demo'
            state.newProject.client = 'Demo client'
            state.newProject.description = 'My first October CMS project!'
        }
    }
}