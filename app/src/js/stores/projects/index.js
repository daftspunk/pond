const Actions = require('./actions')
const Mutations = require('./mutations')
const LogState = require('../../projects/log-state')
const InitializationState = require('../../environments/initialization-state')

module.exports = {
    state: {
        loading: true,
        list: [
            {
                id: 1,
                name: 'Amazon Store',
                starred: true,
                environmentType: 'pond',
                location: '/Users/alexeybobkov/October/pond/test-projects/acme/amazon',
                client: 'ACME client',

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
                client: 'ACME client',

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
                client: 'ACME client',

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
                client: 'ACME client',

                runtime: {
                    status: 'offline', // The projects JSON is temporary, no need to refer to a constant here
                    serverLog: new LogState(),
                    applicationLog: new LogState(),
                    phpErrorLog: new LogState()
                }
            },
            {
                id: 5,
                name: 'October test',
                starred: false,
                environmentType: 'pond',
                location: '/Users/alexeybobkov/October/pond/test-projects/inner/test',
                client: 'Inner projects',

                runtime: {
                    status: 'offline',
                    serverLog: new LogState(),
                    applicationLog: new LogState(),
                    phpErrorLog: new LogState()
                }
            }
        ],
        selectedProject: null,
        newProject: {
            name: '',
            environmentType: '',
            location: '',
            client: '',
            localPort: null,
            initState: new InitializationState.Tracker()
        }
    },

    mutations: Mutations,
    actions: Actions
}