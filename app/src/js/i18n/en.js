module.exports = {
    projects: {
        title: 'Projects',
        find_placeholder: 'Find projects',
        no_project_selected: 'Project is not selected',
        select_project_or: 'Please select a project or',
        create_new_project: 'create a new project',
        add_project: 'Add project',
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
        welcome: 'Welcome to the Pond!',
        create_first_project: 'Create your first project',
        no_projects: 'You don\'t have any projects yet. Create your first project and enjoy October CMS!',
        loading: 'Loading projects...',
        environment_type: {
            unknown: 'Unknown',
            pond: 'Built-in Pond server',
            vagrant: 'Vagrant',
            docker: 'Docker',
            lamp: 'Your own LAMP'
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
            description_placeholder: 'You can use Markdown in this field',
            environment_type: 'Environment type',
            pond_env_description: 'Uses <a href="http://php.net/manual/en/features.commandline.webserver.php">PHP built-in web server</a> and <a href="https://www.sqlite.org/">SQLite database engine</a>. This environment has many limitations, but it\'s perfect for simple projects and exploring October CMS.',
            lamp_env_description: 'Runs October with a web server and MySQL server that you provide. You can use <a href="https://www.mamp.info/en/">MAMP</a>, <a href="https://sourceforge.net/projects/xampp/">XAMPP</a> or similar applications to mantain your servers on macOS and Windows.',
            vagrant_env_description: 'Configures <a href="https://www.vagrantup.com/">Vagrant</a> environment for October.',
            directory_location: 'Directory location',
            error_project_name_empty: 'Project name cannot be empty',
            error_client_name_empty: 'Client name cannot be empty',
            error_environment_type_empty: 'Please select environment type',
            local_port: 'Local TCP port number',
            local_port_description: 'Choose a <a href="https://en.wikipedia.org/wiki/Port_(computer_networking)">TCP port number</a> for your new project. The port should not be used by another Pond project or any other application.',
            new_url_label: 'Your new environment URL',
            error_local_port_empty: 'Please provide the local port number',
            error_local_port_not_integer: 'The local port must be integer',
            error_local_port_used_by_another_project: 'This port is already used by another project',
            error_local_port_used_by_another_app: 'This port cannot be used - it\'s already in use by the OS or another application',
            error_location_empty: 'Please specify the project directory',
            error_location_not_directory: 'The specified path is not a directory',
            error_location_not_empty: 'The specified directory is not empty',
            general_information: 'General information',
            configure_pond_environment: 'Pond environment configuration',
            provisioning: 'Provisioning',
            pond_building_project: 'Pond is building your project...',
            downloading: 'Downloading',
            initializing: 'Initializing environment',
            installing: 'Installing',
            done: 'Done',
            error: 'Error',
            multiple_errors: 'There were multiple installation errors',
            single_error: 'There was an error',
            location_placeholder: 'Click to select location',
            go_to_project: 'Go to the project',
            done_notice: 'The project has been successfully built. You can now start the project\'s environment and begin working with October CMS.',
            project_ready: 'Your project is ready!',
            show_advanced_options: 'Show advanced options',
            administrator_account: 'Administrator account',
            first_name: 'First name',
            error_first_name_empty: 'The administrator first name should not be empty',
            last_name: 'Last name',
            error_last_name_empty: 'The administrator last name should not be empty',
            login: 'Login',
            error_admin_login_empty: 'The administrator login should not be empty',
            error_admin_password_empty: 'The administrator password should not be empty',
            error_admin_email_empty: 'The administrator email should not be empty',
            error_admin_email_invalid: 'The administrator email is not valid',
            error_encryption_key_empty: 'The encryption key should not be empty',
            error_encryption_key_invalid: 'Please use a 32 character string for the encryption key',
            password: 'Password',
            email: 'Email',
            encryption_key: 'Encryption key',
            encryption_key_description: 'This should be a random, 32 character string. <a href="https://octobercms.com/docs/services/hashing-encryption#encryption">Learn more</a> about encryption in October CMS.',
            debug_mode: 'Enable debug mode',
            debug_mode_description: 'When your application is in <a href="https://octobercms.com/docs/setup/configuration#debug-mode">debug mode</a>, detailed error messages with stack traces will be shown on every error that occurs within your application. If disabled, a simple generic error page is shown.',
            edge_updates: 'Enable edge updates',
            edge_updates_description: 'If you are developing with October, it is important to have the latest code base. Enable this option to tell the platform to download and use the development copies of core files and plugins. <a href="https://octobercms.com/docs/setup/configuration#edge-updates">Learn more</a> about bleeding edge updates.',
            development: 'Development',
            security: 'Security',
            other_settings: 'Other settings',
            other_settings_description: 'You can fine-tune the platform using the <a href="https://octobercms.com/docs/setup/configuration">configuration files</a> after the installation process is finished.',
            default_admin_credentials: 'The default back-end administrator login name and password are admin / admin.',
            warning: 'The installer returned a warning',
            multiple_warnings: 'The installer returned some warnings',
            warnings_description: 'Warnings are not critical and you can continue using the installation.',
        }
    },
    settings: {
        title: 'Settings'
    },
    common: {
        close: 'Close',
        save: 'Save',
        continue: 'Continue',
        please_wait: 'Please wait...',
        go_back: 'go back',
        go_back_button: 'Go back',
        unknown_error: 'Unknown error'
    }
}