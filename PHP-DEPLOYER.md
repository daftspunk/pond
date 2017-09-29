# PHP Deployer

This part is written in PHP and executed using the built-in PHP server. We need PHP, because SSH2 class from Node.js doesn't work in browser context (in NW.js, see DEVNOTES.md).

## Common request arguments

All methods accept arguments as JSON in the request body. These common arguments are required for all calls:

```json
{
    "privateKeyPath": "/path/to/private-key",
    "publicKeyPath": "/path/to/public-key",
    "ip": "server IP address",
    "user": "SSH user name"
}
```

## POST /deploy

Runs deployment steps:

* Checks if the server is suitable for October.
* Initializes Pond directories on the server.
* Packs and uploads the source code from the source machine to the server.
* Uploads the configuration files.
* Applies file and directory permissions .
* Runs post-deployment bash scripts.
* Makes one of the environments active.
* Saves logs and environment status file.

Request JSON parameters (must include the `common arguments` listed above):

```json
{
    "params": {
        "update": true|false,
        "projectDirectoryName": "my-project-one",
        "environmentDirectoryName": "production",
        "localProjectPath": "/users/elf/pond-projects/my-project-one",
        "permissions": {
            "directory": "755",
            "file": "664",
            "config": "660"
        },
        "updateComponents": [
            "core": true,
            "plugins": true|["rainlab/users"],
            "themes": true|["website-final"],
            "media": true
        ],
        "configTemplates": {},
        "buildTag": "1.1.0"
    }
}
```

Parameters explained:

* `update` - boolean, required. Determines whether it's a create or update operation.
* `projectDirectoryName` - string, required. Project directory name on the server.
* `environmentDirectoryName` - string, required. Environment directory name on the server.
* `localProjectPath` - string, required. Path to the local project directory.
* `permissions` - object, required. Contains permission masks. Must have the following properties:
    * `directory` - string, required. Directory permission mask.
    * `file` - string, required. Files permission mask.
    * `config` - string, required. Configuration files permission mask.
* `updateComponents` - array, required for updates, ignored for new deployments. Lists components to deploy.
    * `core` - boolean, whether to update the core.
    * `plugins` - boolean or array, whether to update all plugins or names of plugins to update.
    * `themes` - boolean or array, whether to update all themes or names of themes to update.
    * `media` - boolean, whether to update media files.
* `configTemplates` - JSON object, required for new deployments. See the `/configure` operation below.
* `buildTag` - string, optional. Build tag to associate with the deployment, max len: 50.

## POST /configure

Updates configuration files in a server environment.

Request JSON parameters (must include the `common arguments` listed above):

```json
{
    "params": {
        "projectDirectoryName": "my-project-one",
        "environmentDirectoryName": "production",
        "permissions": {
            "directory": "755",
            "file": "664",
            "config": "660"
        },
        "configTemplates": {
            "app.php": {
                "template": "configuration template contents",
                "vars": {
                    "var1": "value1",
                    ...
                }
            },
            ...
        }
    }
}
```

Parameters explained:

* `projectDirectoryName` - string, required. Project directory name on the server.
* `environmentDirectoryName` - string, required. Environment directory name on the server.
* `permissions` - object, required. Contains permission masks. Must have the following properties:
    * `directory` - string, required. Directory permission mask.
    * `file` - string, required. Files permission mask.
    * `config` - string, required. Configuration files permission mask.
* `configTemplates` - object, required. Defines names, content and variables for configuration files. Object keys correspond the configuration file names (`app.php`, `sms.php`, etc.). Each configuration object must have these properties:
    * `template` - text content of the configuration file with variable placeholders, see below.
    * `vars` - object containng variable names and values.

Configuration files use Twig engine for rendering:

```php
<?php

return [
    'timezone' => {{app.timezone}},
    ...
```

The configuration file templates are provided by the NW.js part of the application. In the beginning they will be fixed, but it's possible to make them editable so that each project has its own configuration file templates.

## Security of the Pond server environments

* [ ] **TODO** - review this section

There will be a special user user with configurable name, responsible for deploying the application and running Apache (this is TBD, it's also possible Apache and the special user to share a same group instead). Project files and directories will have permissions limited to that user (or its group, TBD).

The deployment user will have the password access disabled and will use key-based authentication method.

### File permissions

File permissions are configurable by the calling code. By the recommended configuration files created by Pond are readable and writeable by the special deployment user and group and readable by other users. User can do `sudo su [deployment-user-name]` in order to update files deployed by Pond

By the recommended permission configuration, configuration files are readable and writable only by the special deployment user and its group, so that Apache can access them and other users cannot access them.