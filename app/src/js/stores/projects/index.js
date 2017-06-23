const Actions = require('./actions')
const Mutations = require('./mutations')
const LogState = require('../../projects/log-state')

module.exports = {
    state: {
        loading: true,
        list: [
            // Keep this for reference
            // {
            //     id: 1,
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