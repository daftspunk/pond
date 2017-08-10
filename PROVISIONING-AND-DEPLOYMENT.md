# Pond provisioning and deployment

## What Pond knows about DO

These are kept in Pond settings.

- A list of DO accounts with SSL certificates.

## What a Pond project knows about DO servers

These are kept in Pond project configuration.

* Type of the server (reserved - currently just DO)
* DO account (reference)
* List of droplets associated with the project
* A build tag of the last successful deployment
* Green or Blue marker of the last successful deployment (will be needed when adding a new server to existing balanced environment). **Not needed:** this can always be loaded from the project's servers Pond metadata. If there are no associated servers with the project, just make Blue active on a new server.
* Secret prefix for accessing the blue and green environments.
* Domain name
* Post-provision and post-deployment bash scripts

## What a server knows about Pond

* Whether the Blue or Green environment is active at the moment
* A tag of the currently deployed build
* Log of deployment operations

## Deploying a project, flow diagram

* Single server
    * New server
    * Bind to existing server
        * Select droplet to bind to
* Load balanced infrastructure
    * New infrastructure
    * Bind to existing infrastructure
        * Select load balancer, droplets, DB server, session storage server.

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

These things can be factored out from the single and balanced infrastructures. It looks like everything can be done with a large bash command. Something bash language with conditions and variables.

Requirements for the server - web server and database server. Not necessary Apache, not necessary MySQL. We only need two directories and DB server type connection and connection information. This could be done later.

* Setup Apache, PHP (these can be bash commands)
* Configure Apache hosts (these can be bash commands - copy templates)
* If needed - setup  and configure MySQL server (bash commands)
* Create Blue and Green directories (bash commands)
* Run post-provision bash scripts

Code deployment steps:

* Create Pond metadata directory
* Make Blue or Green environment active (Pond should know which one to active)
* Save required metadata
* Run post-deployment bash scripts

## Infrastructure status

Pond projects should be able to request and show the infrastructure status: what droplets are registered, their status (running or stopped), which environment is current, what is the last deployed build tag, when was the last deployment. Also, Pond log for every server should be available with clicking a button.
