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
                        online: true
                    },
                    {
                        name: 'RESTful API',
                        starred: true,
                        serverType: 'built-in',
                        online: false
                    },
                    {
                        name: 'Clients portal',
                        starred: false,
                        serverType: 'built-in',
                        online: true
                    },
                    {
                        name: 'Ecommerce website',
                        starred: false,
                        serverType: 'built-in',
                        online: false
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
                        online: false
                    }
                ]
            }
        ],
        selectedProject: {},
        listFilterString: ''
    },

    mutations: {
        SET_SELECTED_PROJECT (state, project) {
            state.selectedProject = project
        }
    },

    actions: {
        setSelectedProject (context, project) {
            context.commit('SET_SELECTED_PROJECT', project)
        }
    }
}