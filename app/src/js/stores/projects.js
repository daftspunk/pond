module.exports = {
    state: {
        clients: [
            {
                name: 'ACME client',
                projects: [
                    {
                        name: 'Amazon Store',
                        starred: true,
                        serverType: 'built-in',

                        metadata: {
                            online: true
                        }
                    },
                    {
                        name: 'RESTful API',
                        starred: true,
                        serverType: 'built-in',

                        metadata: {
                            online: false
                        }
                    },
                    {
                        name: 'Clients portal',
                        starred: false,
                        serverType: 'built-in',

                        metadata: {
                            online: true
                        }
                    },
                    {
                        name: 'Ecommerce website',
                        starred: false,
                        serverType: 'built-in',

                        metadata: {
                            online: false
                        }
                    }
                ]
            },
            {
                name: 'Inner projects',
                projects: [
                    {
                        name: 'October test',
                        starred: false,
                        serverType: 'built-in',

                        metadata: {
                            online: false
                        }
                    }
                ]
            }
        ],
        selectedProject: null,
        selectedClient: null
    },

    mutations: {
        SET_SELECTED_CLIENT_AND_PROJECT (state, payload) {
            state.selectedProject = payload.project
            state.selectedClient = payload.client
        },
        SET_STARRED (state, payload) {
            payload.project.starred = payload.starred
        }
    },

    actions: {
        setSelectedClientAndProject (context, payload) {
            context.commit('SET_SELECTED_CLIENT_AND_PROJECT', payload)
        },
        toggleProjectStar (context, project) {
            context.commit('SET_STARRED', {
                project: project,
                starred: !project.starred
            })
        }
    }
}