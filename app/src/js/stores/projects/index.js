const Actions = require('./actions')
const Mutations = require('./mutations')
const LogState = require('../../projects/log-state')

module.exports = {
    state: {
        loading: true,
        clients: [
            {
                name: 'ACME client',
                projects: [
                    {
                        id: 1,
                        name: 'Amazon Store',
                        starred: true,
                        environmentType: 'pond',
                        location: '/Users/alexeybobkov/October/pond/test-projects/acme/amazon',

                        runtime: {
                            status: 'offline', // The projects JSON is temporary, no need to refer to a constant here
                            serverLog: new LogState(),
                            applicationLog: new LogState(),
                            phpErrorLog: new LogState()
                        }
                    },
                    {
                        id: 2,
                        name: 'RESTful API',
                        starred: true,
                        environmentType: 'pond',
                        location: '/Users/alexeybobkov/October/pond/test-projects/acme/restful',

                        runtime: {
                            status: 'online', // The projects JSON is temporary, no need to refer to a constant here,
                            serverLog: new LogState(),
                            applicationLog: new LogState(),
                            phpErrorLog: new LogState()
                        }
                    },
                    {
                        id: 3,
                        name: 'Clients portal',
                        starred: false,
                        environmentType: 'pond',
                        description: 'Static landing pages for various ACME marketing campaigns, hosted on a separate server. Project [in Basecamp](http://google.com).',
                        location: '/Users/alexeybobkov/October/pond/test-projects/acme/clients-portal',
                        localPort: 8002,

                        runtime: {
                            status: 'offline', // The projects JSON is temporary, no need to refer to a constant here
                            serverLog: new LogState(),
                            applicationLog: new LogState(),
                            phpErrorLog: new LogState()
                        }
                    },
                    {
                        id: 4,
                        name: 'Ecommerce website',
                        starred: false,
                        environmentType: 'pond',
                        location: '/Users/alexeybobkov/October/pond/test-projects/acme/ecommerce',
                        localPort: 8001,

                        runtime: {
                            status: 'offline', // The projects JSON is temporary, no need to refer to a constant here
                            serverLog: new LogState(),
                            applicationLog: new LogState(),
                            phpErrorLog: new LogState()
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
                        location: '/Users/alexeybobkov/October/pond/test-projects/inner/test',

                        runtime: {
                            status: 'offline',
                            serverLog: new LogState(),
                            applicationLog: new LogState(),
                            phpErrorLog: new LogState()
                        }
                    }
                ]
            }
        ],
        selectedProject: null,
        selectedClient: null
    },

    mutations: Mutations,
    actions: Actions
}