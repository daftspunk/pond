# Pond provisioning and deployment

## Problems with providing a server-based service

Initially, we have two options - implement a server-based service like Forge, or have just a desktop client. With our goals of having a life style business and a low level of real-time responsibility, the desktop option is much more appealing, although there're trade offs, see below.

**Problems with the server options**

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

Each server environment has two deployment environments - blue and green. One of the deployment environments is always enabled and receives Internet traffic, and another one is used then website updates are deployed. After deploying updates it's possible to connect to the just updated and still inactive deployment environment with a browser and test the updated features. If the updated deployment environment works as expected, it can be made active using Pond environment manager.

## What Pond knows about DO

These are kept in Pond settings.

- A list of DO accounts with SSL certificates.

## What a Pond project knows about DO servers

These are kept in Pond project configuration.

* Type of the server (reserved - currently just DO)
* DO account (reference)
* List of server environments associated with the project
  * Server environment type (single server / load balanced)
  * List of droplets associated with the server environment
  * Environment domain name
  * A build tag of the last successful deployment
  * Green or Blue marker of the last successful deployment (will be needed when adding a new server to existing balanced environment). **Not needed:** this can always be loaded from the project's servers Pond metadata. If there are no associated servers with the project, just make Blue active on a new server.
  * Secret prefix for accessing the blue and green environments.
  * Project directory name on the server(s)
  * Post-provision and post-deployment bash scripts
  * Deployment .pondignore file - what directories to ignore on deployment (config files are auto-ignored)
  * Configuration file templates for session, database, cache and other files.

## What a server knows about Pond

* Whether the Blue or Green environment is active at the moment
* A tag of the currently deployed build
* Log of deployment operations

## Deploying a project, flow diagram

* Create server environment from scratch
  * Single server
      * New server
  * Load balanced environment
      * New environment
* Create environment and bind to existing DO servers

### Deploying a new single server

* What DO account to use (create one if needed).
* Ask for the domain name (notify that it should be registered, with a link to the registration documentation page).
* Advanced, hidden by default - what DO image to use.
* Whether to create a database server on that server, or use existing (allow to select a droplet). 
* Ask for the MySQL droplet name, DB name, user name and credentials. If the MySQL droplet doesn't exist, suggest that MySQL will be deployed one the same server.
* Ask whether data from the database should be transferred too.
* Ask whether attachment files should be transferred too.
* Ask for the build tag.
* Ask for the secret prefix to be used for direct access of the blue and green environments.
* Provision the server.
* If the domain already exists in DO, ask if they want to update the A record now to point to the new droplet. Otherwise add the domain and create A and CNAME records.
* The finish page should tell that the server is provisioned and how to access the production environment and Blue/Green environments.

## Operations required to provision a droplet

These things can be factored out from the single and balanced environments. It looks like everything can be done with a large bash command. Something bash language with conditions and variables.

Requirements for the server - web server and database server. Not necessary Apache, not necessary MySQL. We only need two directories and DB server type connection and connection information. This could be done later.

* Setup Apache, PHP (these can be bash commands)
* Create web user and group
* Initialize environment variables
* Configure Apache hosts (these can be bash commands - copy templates)
* If needed - setup  and configure MySQL server (bash commands)
* Create blue, green, config, storage, current directories (bash commands)
* Run post-provision bash scripts

Code deployment steps on first deployment:

* Make a complete copy of the October installation in the blue and green directories, excluding configuration files and with applying the .pondignore file.
* If requested - upload files and database.
* Populate the /config directory using templates and user-provided variables.
* Create the configuration files in the blue and green directories.
* Run post-deployment bash scripts
* Make Blue or Green environment active (Pond should know which one to make active)
* Save pond logs entries.

Code deployment steps on subsequent deployments:

* Update blue or green directory with applying the .pondignore file.
* Save required metadata
* Run post-deployment bash scripts
* Save pond logs entries

Switching to another deployment environment (blue/green) should not be automatic when deploying to an existing server environment. This should be performed from the server environment status area, allowing the user to test the new copy before activating it.

There should be an ability to unbind Pond project from a droplet and start the deployment over - to another server, etc..

## Deploying themes

Themes are deploying like regular directories. There will be no issues with assets as they are stored in separate environment directories (blue/green), and accessed via a symbolic link bound to a virtual host.

## Directory layout on a server

```
/var/www/pond/projects
  /project1
    /production
      /config
      /blue
        /storage - (symlink to the common storage)
      /green
        /storage - (symlink to the common storage)
      /current (symlink)
      /metadata
        log
      /storage
        /app
        /framework
          /sessions
    /staging
      ...
    /test1
      ...
```

## Environment status

Pond projects should be able to request and show the server environment status: what droplets are registered, their status (running or stopped), which environment is current, what is the last deployed build tag, when was the last deployment. Also, Pond log for every server should be available with clicking a button.

## Keeping some data on the could servers

Deployed environments must keep enough metadata to determine what projects the belong to, just for convenience of administrators. Droplets will use tags matching project names.