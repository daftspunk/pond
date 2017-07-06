const Actions = require('./actions')
const Mutations = require('./mutations')
const LogState = require('../../projects/log-state')

module.exports = {
    state: {
        loading: true,
        list: [
            // Keep this for reference
            // {
            //     _id: 1,
            //     _rev: '1-A6157A5EA545C99B00FF904EEF05FD9F',
            //     name: 'Amazon Store',
            //     starred: true,
            //     environmentType: 'pond',
            //     location: '/Users/alexeybobkov/October/pond/test-projects/acme/amazon',
            //     client: 'ACME client',

            //     runtime: {
            //         status: 'offline',
            //         serverLog: new LogState(),
            //         applicationLog: new LogState(),
            //         phpErrorLog: new LogState()
            //     }
            // }
        ],
        selectedProject: null,
        newProject: {}
    },

    mutations: Mutations,
    actions: Actions
}