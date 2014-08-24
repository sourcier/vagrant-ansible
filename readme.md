# Vagrant + Ansible
Created: 10 Jan 2014
Author:  Roger Ragulan Rajaratnam <roger@ragusource.com>
Website: http://ragusource.com
Version: 0.3.0

## Dependencies

1. [Vagrant](http://vagrantup.com/)
2. [Ansible](http://ansible.com/)

Ansible can be installed via homebrew:

```bash
$ brew install ansible
```

## Check out the project

```bash
$ git clone git@bitbucket.org:ragusource/vagrant.git
$ cd vagrant
$ ant init
```

Edit Vagrantfile if you need make any changes. If you modify the IP address for hobo you will also need to update the
inventory file located here: anisble/inventory.ini.

## PHP modules

There are two types of modules that can be installed, ones provided by apt and ones that have to be built. You can easily add
apt provided modules by adding them to the modules node under the php node:

```yml
php:
    modules:
        - php5-xdebug
        - php5-mysql
```

__php5-xdebug is enabled by default__

The are currently two modules (phalcon, ioncube) that can be built and added, you can enable them by setting the relevant node
to true under the php node:

### Ioncube

```yml
php:
    ioncube: true
```

### Phalcon

```yml
php:
    phalcon: true
```

## Add virtual hosts

Open the ansible extra vars file for the host ```ansible/vars/<host>.yml```, add extra virtual hosts by adding the
following:


```yml
---
apache:
nfs: true
log_root: "/vagrant/logs"
vhosts:
  - server_name: "example.dev"
    document_root: "/var/www/example.dev/public"
    nfs_mount: "10.0.0.1:/Volumes/RAGUSOURCE/ragusource-web"
```

The apache.vhost node is a collection and multiple vhosts can be added. The following optional params can be added to each vhost:

```yml
server_aliases: 'example1.dev example2.dev'
```

```yml
env_variables:
    - name: ENVIRONMENT
      value: dev
```

```yml
headers:
    - name: Access-Control-Allow-Origin
      value: '*'
```

```yml
types:
    - extensions:
            - .phar
      handler: application/x-httpd-php
```

## Provision

You can start and provision the machine by running the following:

```bash
$ vagrant up --provision
```

## Using the Digital Ocean provider

Uncomment the ```digitalocean_provider``` provider and ```tramp``` config nodes. Insert your Digital Ocean client Id
API key into the provider section:

```ruby
provider.client_id = 'xxxx'
provider.api_key = 'xxxx'
```

Up the vagrant box using:

```bash
$ vagrant up tramp --provider=digital_ocean
```

### Installing the Digital Ocean provider

If you do not have the Digital Ocean provider installed, issue the following command:

```bash
$ vagrant plugin install vagrant-digitalocean
```

## Known Issues

### Phalcon fails to build

If you get the following error when trying to compile phalcon:

```
Error: no such instruction: `vfmadd312sd .LC2013(%rip),%xmm0,%xmm1'
```

You can manually build phalcon by:

```bash
$ vagrant ssh
$ cd cphalcon/build/64bits
$ sudo ./configure --enable-phalcon
$ sudo make
$ sudo make install
$ sudo cp /vagrant/ansible/roles/phalcon/files/phalcon.ini /etc/php5/apache2/conf.d/.
$ sudo cp /vagrant/ansible/roles/phalcon/files/phalcon.ini /etc/php5/cli/conf.d/.
```
