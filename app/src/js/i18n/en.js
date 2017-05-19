module.exports = {
    projects: {
        title: 'Projects',
        find_placeholder: 'Find projects',
        no_project_selected: 'Project is not selected',
        select_project_or: 'Please select a project or',
        create_new_project: 'create a new project',
        settings_link: 'settings',
        start: 'Start',
        stop: 'Stop',
        deploy: 'Deploy',
        server: 'Server',
        location: 'Location',
        local: 'Local',
        production: 'Production',
        application_log: 'Application log',
        server_log: 'Web server log',
        php_error_log: 'PHP error log',
        refresh: 'Refresh',
        clear: 'Clear',
        environment_type: {
            unknown: 'Unknown',
            pond: 'Built-in Pond server',
            vagrant: 'Vagrant',
            docker: 'Docker',
            lamp: 'Bring your own LAMP'
        },
        platform_type: {
            win32: 'Windows',
            darwin: 'macOS'
        },
        create_project: {
            title: 'Create project',
            project_name: 'Project name',
            client_name: 'Client',
            description: 'Description',
            environment_type: 'Environment type',
            pond_env_description: 'Uses <a href="http://php.net/manual/en/features.commandline.webserver.php">PHP built-in web server</a> and <a href="https://www.sqlite.org/">SQLite database engine</a>. This environment has many limitations, but it\'s perfect for simple projects and exploring October CMS.',
            lamp_env_description: 'Runs October with a web server and MySQL server that you provide. You can use <a href="https://www.mamp.info/en/">MAMP</a>, <a href="https://sourceforge.net/projects/xampp/">XAMPP</a> or similar applications to mantain your servers on macOS and Windows.',
            vagrant_env_description: 'Configures <a href="https://www.vagrantup.com/">Vagrant</a> environment for October.',
            directory_location: 'Directory location',
            error_project_name_empty: 'Project name cannot be empty',
            error_client_name_empty: 'Client name cannot be empty',
            error_environment_type_empty: 'Please select environment type'
        }
    },
    settings: {
        title: 'Settings'
    },
    common: {
        close: 'Close',
        save: 'Save',
        continue: 'Continue'
    }
}