This Vagrant environment emulates a remote server (droplet) to test and debug deployment procedures locally. 

## Initializing the environment

Make sure you have latest Vagrant and VirtualBox installed.

In the Terminal go to the `target-server-dev-environment` directory and start Vagrant environment with `vagrant up`. Then SSH to the box (`vagrant ssh`) and run the commands below. 

TODO: this should be fully automated with `config.vm.provision "shell", path: pathToShellScriptToRun`. SSH keys are available after the box boots in /var/target-server-dev-environment/keys/ and can be copied directly inside the box.

TODO: the provision script should also create an available and enabled virtual host dev-latest-deployed-environment.com pointing to `/var/www/latest-deployment-environment/current`

```sh
sudo adduser --disabled-password --gecos "" deploy
sudo chown -R deploy:deploy /var/www
sudo chmod 777 /var/www
sudo su - deploy
mkdir ~/.ssh
nano ~/.ssh/authorized_keys
  [paste keys/id_rsa.pub file content, save the file and exit nano]
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh
exit
cd /var/php-deployer
composer install
cd ~
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update
sudo apt-get -y install php7.1
sudo apt-get -y install php7.1-ssh2
sudo apt-get -y install php7.1-xml
sudo apt-get -y install php7.1-mbstring
sudo apt-get -y install php7.1-pdo-mysql
sudo apt-get update
sudo apt-get -y install php7.1-zip
mysql
   GRANT ALL PRIVILEGES ON *.* TO 'app'@'localhost' IDENTIFIED BY 'password';
   FLUSH PRIVILEGES;
   exit
exit
```

After these steps you should be able to SSH to the running box as `deploy` user from the `target-server-dev-environment` directory: 

```
ssh -i keys/id_rsa deploy@192.168.33.10
```

**Important:** this environment is disposable. You can trash the Vagrant box with `vagrant destroy` and then create it again with `vagrant up` and running the commands above. This might be required after running deployment tests multiple times.

## Running PHP deployer locally

To access PHP deployer API directly (for example, to test it with Advanced Rest Client), SSH into the `target-server-dev-environment` vagrant box, then

```
cd /var/php-deployer/public && php -S 0.0.0.0:8001
```

After that the Deployer is available by this address: `http://192.168.33.10:8001/`

## Running PHP deployer unit tests

Run tests in the `target-server-dev-environment` box. Unit tests require the box configuration described above.

```
vagrant ssh
cd /var/php-deployer
composer test 
  [or, a bit faster start]
php vendor/bin/phpunit --colors=always 
```
## Previewing latest full deployment

There's a way to create a test full deployment with

```
TEST_FULL_DEPLOYMENT=true php vendor/bin/phpunit --filter testFullDeployment
```

The environment can be accessed through the browser as `http://dev-latest-deployed-environment.com/`. Make sure you added this line to `hosts`:

```
192.168.33.10   dev-latest-deployed-environment.com
```

The test full deployment is not fully functional and depends on the current environment status. Most likely the database-related features won't work.
