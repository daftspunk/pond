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
                        starred: false,
                        serverType: 'built-in',
                        online: false
                    }
                ]
            },
            {
                name: 'Inner projects',
                projects: [

                ]
            }
        ]
    }
}