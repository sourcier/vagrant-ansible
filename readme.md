# Vagrant + Ansible
Created: 10 Jan 2014
Author:  Roger Ragulan Rajaratnam <roger@ragusource.com>
Website: http://ragusource.com
Version: 0.2.1

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

## Add virtual hosts

Open the ansible extra vars file for the host ```ansible/vars/<host>.yml```, add extra virtual hosts by adding the
following:


```yml
---
  apache:
    nfs: true
    log_root: "/vagrant/logs"
    vhosts:
      -
        server_name: "example.dev"
        document_root: "/var/www/example.dev/public"
        nfs_mount: "10.0.0.1:/Volumes/Development/RAGUSOURCE/ragusource-web"

```

The apache.vhost node is a collection and multiple vhosts can be added.

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