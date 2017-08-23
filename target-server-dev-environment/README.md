This Vagrant environment emulates a remote server (droplet) to test and debug deployment procedures locally. 

## Initializing the environment

Make sure you have latest Vagrant and VirtualBox installed.

In the Terminal go to the `target-server-dev-environment` directory and start Vagrant environment with `vagrant up`. Then SSH to the box (`vagrant ssh`) and run the commands below. 

TODO: this can be fully automated with `config.vm.provision "shell", path: pathToShellScriptToRun`. See `https://github.com/rlerdorf/php7dev/blob/master/scripts/php7dev.rb` for copying SSH keys from the host machine to the box (a simpler way would be to share `target-server-dev-environment` directory with Vagrant and copy the files inside the box, internally).

```
sudo adduser --disabled-password --gecos "" deploy
sudo chown -R deploy:deploy /var/www
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
wget https://phar.phpunit.de/phpunit-6.3.phar
chmod +x phpunit-6.3.phar
sudo mv phpunit-6.3.phar /usr/local/bin/phpunit
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get -y install php7.1
sudo apt-get install php7.1-ssh2
sudo apt-get install php7.1-xml
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

TODO