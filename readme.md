# Vagrant + Ansible
Created: 10 Jan 2014
Author:  Roger Ragulan Rajaratnam <roger@ragusource.com>
Website: http://ragusource.com
Version: 0.3.1

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

## Virtualhosts

Open the ansible extra vars file for the host ```ansible/vars/<host>.yml```, add extra virtual hosts by adding the
following:


```yml
---
vhosts:
  - server_name: "example.dev"
    document_root: "/var/www/example.dev/public"
```

The vhosts node is a collection and multiple vhosts can be added. The following optional params can be added to each vhost:

```yml
server_aliases: 'example1.dev example2.dev'
```

```yml
environment_variables:
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

## DNS

The vm provides an instance of dnsmasq which can be configured by adding the following config:

dns:
    addresses:
        - {domain: dev, ip: 10.0.0.3}

Configure local dns by doing the following:

```bash
$ sudo touch /etc/resolver/dev
$ sudo cat nameserver 10.0.0.3 > /etc/resolver/dev
```

## NFS

It is possible to use NFS for mounting the code inside the VM.

```yml
nfs:
    enabled: true
    mounts:
        - {source: '10.0.0.1:/foo', destination: '/bar'}
```

On OSX you can define NFS shares by doing the following:

```bash
$ sudo touch /etc/exports
$ sudo echo '/foo -alldirs -mappall=${USERNAME}:staff' > /etc/exports
```

## Provision

You can start and provision the machine by running the following:

```bash
$ vagrant up --provision
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
