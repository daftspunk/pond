module.exports = {
    state: {
        clients: [
            {
                name: 'ACME client',
                projects: [
                    {
                        id: 1,
                        name: 'Amazon Store',
                        starred: true,
                        environmentType: 'pond',
                        location: '/Users/alexeybobkov/October/pond/acme/amazon',

                        runtime: {
                            online: true
                        }
                    },
                    {
                        id: 2,
                        name: 'RESTful API',
                        starred: true,
                        environmentType: 'lamp',
                        location: '/Users/alexeybobkov/October/pond/acme/restful',

                        runtime: {
                            online: false
                        }
                    },
                    {
                        id: 3,
                        name: 'Clients portal',
                        starred: false,
                        environmentType: 'pond',
                        description: 'Static landing pages for various ACME marketing campaigns, hosted on a separate server. Project [in Basecamp](http://google.com).',
                        location: '/Users/alexeybobkov/October/pond/acme/clients-portal',

                        runtime: {
                            online: true
                        }
                    },
                    {
                        id: 4,
                        name: 'Ecommerce website',
                        starred: false,
                        environmentType: 'docker',
                        location: '/Users/alexeybobkov/October/pond/acme/ecommerce',

                        runtime: {
                            online: false
                        }
                    }
                ]
            },
            {
                name: 'Inner projects',
                projects: [
                    {
                        id: 5,
                        name: 'October test',
                        starred: false,
                        environmentType: 'pond',
                        location: '/Users/alexeybobkov/October/pond/inner/test',

                        runtime: {
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