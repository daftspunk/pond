# Pond provisioning and deployment

## Problems with providing a server-based service

Initially, we have two options - implement a server-based service like Forge, or have just a desktop client. With our goals of having a life style business and a low level of real-time responsibility, the desktop option is much more appealing, although there're trade offs, see below.

### Problems with the server-based service

1. **Security.** We would need to either use a special user(s) with a key pair for accessing clients' servers, or transmit the client's private key from Pond to our server in order to work with the client's server. Keeping private keys is risky - if we get hacked, the hacker could obtain access to all customer's servers and we won't even be able to fix it promptly.
2. **Reliability.** If our server is overloaded, everybodys experience latency. If our server is down, nobody can deploy.
3. **Keeping important client data.** The infrastructure configuration might be an important aspect of a business. A web studio could have multiple environments with complex configuration. If we lose somebody's configuration, this could be fatal for the business.

**What is a better option**

A better solution would be to offload the security responsibilities to our users and let Pond to act on behalf of the user, from the user's computer.

This approach has known trade offs - if there's no centralized storage for the configuration. This will be solved with environment configuration stored in a JSON file, which can be shared with git between multiple users.

On the other hand, a desktop client is a very simple tool which could be picked up and understood by a broader audience.

## Terminology

### Server environment

A copy of the website running on a web server(s). Server environments can be single server and load balanced. Each project can have multiple server environments, for different needs: production, staging, experiments, etc. Server environments of different types can be used with a single project. For example, the production environment can be load balanced and use multiple servers. In the same time, the staging environment can be single server.

Single server environments can host multiple projects. This means, that a single DO droplet can run multiple websites. A single server can run multiple server environments of each website. In other words, a single server can be used to host production, staging and other environments for different websites.

On the other hand, a load balanced environment is supposed to run only a single website. Commonly it's used to run high traffic websites and having multiple websites on a load balanced environment just doesn't make much sense.

### Deployment environment

Each server environment has two deployment environments - `blue` and `green`. One of the deployment environments is always enabled and receives Internet traffic, and another one is used then website updates are deployed. After deploying updates it's possible to connect to the just updated and still inactive deployment environment with a browser and test the updated features. If the updated deployment environment works as expected, it can be made active using Pond environment manager.

We always update the inactive deployment environment, e.g. if the currently active environment is `blue`, we will deploy to green and vice versa.

Deployment environments belonging to a same server environment share the same configuration, uploaded files, media and sessions. 

## What Pond knows about DigitalOcean accounts

We keek a list of DigitalOcean accounts in Poind. Information about each account includes:

* SSL certificates

## What a Pond project knows about DigitalOcean droplets

These parameters are kept in Pond project configuration.

* Type of the server (reserved - currently just DO).
* DO account (reference).
* List of server environments associated with the project.
  * Server environment type (single server / load balanced).
  * List of droplets associated with the server environment (single droplet for single server environment).
  * Environment domain name.
  * Secret prefix for accessing the `blue` and `green` deployment environments with a browser.
  * Project directory name on the server(s).
  * Post-provision and post-deployment bash scripts.
  * `.pondignore` file - what directories to ignore on deployment (config files are auto-ignored)
  * Configuration file templates for session, database, cache and other files.
  * Droplet-specific user names and permissions information, see below.

Note: the following parameters are droplet-specific and can be stored in a separate droplet database and shared between multiple projects and server environments.

  * MySQL `root` password.
  * SSH user name.
  * Deployment user group name.
  * Permission masks to be used for directories, regular files and configuration files.

## What metadata Pond keeps on a droplet

Each server environment includes `metadata` directory, which holds the `status.json` file and log files.

* Whether the `blue` or `green` environment is active at the moment.
* A tag of the currently deployed build.
* Log of deployment operations, in the `metadata/logs` directory.

Structure of `/metadata/status.json` file:

```json
{
  "deploymentEnvironments": {
    "blue": {
      "lastDeployment": "datetime",
      "buildTag": "string"
    },
    ...
  },
  "deploymentLog": {
    [
      {
        "datetime": "datetime",
        "status": "success|fail",
        "type": "deploy|swap",
        "components": ["core", "config", ...],
        "environment": ["blue"],
        "ip": "1.2.3.4"
      }
    ],
    ...
  }
}
```

The `deploymentLog` part keeps information only about X days of latest deployments.

## Droplets used for deployments

Pond expects droplets it deploys projects to are provisioned with Pond. When a droplet is provisioned, it gets the following components:

* Apache web server.
* PHP.
* MySql - optional.
* User and group, required for deployments.

There can be dedicated MySQL droplets that do not host web applications. Pond does not manage such droplets, but allows projects to connect to them. Users must create databases on those MySQL servers by themselves.

### Deploying a project to a new single server

* Ask what DO account to use (create one if needed).
* Ask for the domain name (notify that it should be registered, with a link to the registration documentation page).
* Advanced, hidden by default - what DO image to use.
* Ask for the MySQL droplet name, DB name, user name and password.
* If the MySQL server is going to be hosted on the new droplet, ask to enter the MySQL root password. This password will be set for MySQL `root` user when the database server is created and saved in the droplet configuration.
* Ask for permission masks to be used on the droplet.
* Ask for the deployment user name and group.
* Ask whether data from the database should be transferred too.
* Ask whether attachment files should be transferred too.
* Ask for the build tag.
* Ask for the secret prefix to be used for direct access of the `blue` and `green` environments.
* Provision the server.
* Deploy the project
* If the domain already exists in DO, ask if they want to update the A record now to point to the new droplet. Otherwise add the domain and create A and CNAME records.
* The finish page should tell that the server is provisioned and how to access the production environment and `blue`/`green` environments.

## Operations required to provision a droplet

* Setup Apache
* Setup PHP.
* Create web user and group.
* Initialize environment variables.
* If needed - setup and configure MySQL server. Set MySQL `root` password provided by the user.

Code deployment steps on first deployment:

* Make a complete copy of the October installation in the `blue` and `green` directories, excluding configuration files and with applying the .pondignore file.
* If requested - upload files and database dump. At this point we only support database initialization for MySQL.
* Populate the `/config` directory using templates and user-provided variables..
* Run post-deployment bash scripts.
* Make Green environment active.
* Save pond logs entries.
* Create Apache virtual host file.
* Create the database if the MySQL server is hosted by the same droplet.
* Populate the database, if requested.
* Run post-provision bash scripts.

Code deployment steps for updating an existing server environment:

* Update `blue` or green `directory` with applying the .pondignore file.
* Save required metadata.
* Run post-deployment bash scripts.
* Save pond logs entries.

Switching to another deployment environment (`blue`/`green`) is not automatic when deploying to an existing server environment. This should be performed from the server environment status area, allowing the user to test the new copy before activating it.

There should be an ability to unbind Pond project from a droplet and start the deployment over - to another server, etc. Update: projects are bound to droplets through server environments. In order to unbind we just delete a server environment.

## .pondignore

`.pondignore` is a text file with patterns for excluding from the deployment archives. One pattern per line. Allows comments starting with `#`.

## Deploying themes

Themes are deploying like regular directories. There will be no issues with assets as they are stored in separate environment directories (blue/green), and accessed via a symbolic link bound to a virtual host.

## Directory layout on a server

```
/var/www/pond/projects
  /project1
    /production
      /config
      /blue
        /storage/app - (symlink to the common storage/app)
        /storage/framework/sessions - (symlink to the common storage/framework/sessions)
      /green
        /storage/app - (symlink to the common storage/app)
        /storage/framework/sessions - (symlink to the common storage/framework/sessions)
      /current (symlink to blue or green)
      /metadata
        /log
      /storage
        /app
        /framework
          /sessions
      /pond-tmp
    /staging
      ...
    /test
      ...
```

## Environment status

Pond projects should be able to request and show the server environment status: what droplets are registered, their status (running or stopped), which environment is current, what is the last deployed build tag, when was the last deployment. Also, Pond log for every server should be available with clicking a button.

## Billing

* [ ] **TODO** - review

There will be 2 points when we contact our server - when the deployment starts to check if the account has positive balance and when the deployment is almost finished, just before we report to the user that the deployment is done, when it's know that it was successful. We can measure the number of pre and post deployment events for a contacts to estimate whether it could be an abuse.

## Configuration files

Configuration files that we manage are created on first deployment basing on the configuration variable values set by the user. We can also consider using environment variables, but this might be not a good idea, because we can deploy multiple projects and environments to a same server and would need to deal environment variable naming.