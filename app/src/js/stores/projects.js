module.exports = {
    state: {
        clients: [
            {
                name: 'ACME client',
                projects: [
                    {
                        name: 'Amazon Store',
                        starred: true,
                        serverType: 'pond',
                        location: '/Users/alexeybobkov/October/pond/acme/amazon',

                        metadata: {
                            online: true
                        }
                    },
                    {
                        name: 'RESTful API',
                        starred: true,
                        serverType: 'lamp',
                        location: '/Users/alexeybobkov/October/pond/acme/restful',

                        metadata: {
                            online: false
                        }
                    },
                    {
                        name: 'Clients portal',
                        starred: false,
                        serverType: 'pond',
                        description: 'Static landing pages for various ACME marketing campaigns, hosted on a separate server. Project [in Basecamp](http://google.com).',
                        location: '/Users/alexeybobkov/October/pond/acme/clients-portal',

                        metadata: {
                            online: true
                        }
                    },
                    {
                        name: 'Ecommerce website',
                        starred: false,
                        serverType: 'docker',
                        location: '/Users/alexeybobkov/October/pond/acme/ecommerce',

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
                        serverType: 'pond',
                        location: '/Users/alexeybobkov/October/pond/inner/test',

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