# Vagrant + Ansible
Created: 10 Jan 2014
Author:  Roger Ragulan Rajaratnam <roger@ragusource.com>
Website: http://ragusource.com
Version: 0.1.2

## Dependencies

1. [Vagrant](http://vagrantup.com/)
2. [Ansible](http://ansible.com/)

## Check out the project

```bash
$ git clone git@bitbucket.org:ragusource/vagrant.git
$ cd vagrant
$ ant prepare
$ vagrant up
```

Edit Vagrantfile if you need make any changes.

## Add a virtual host

Open the Vagrantfile and edit the ansible.extra_vars hash so that the apache node looks like this:

```python
'apache' => {
    'nfs' => true,
    'vhosts' => [
        {
            "server_name" => 'example.dev',
            "document_root" => '/var/www/example.dev/public',
            "nfs_mount" => '10.0.0.1:/Volumes/Development/RAGUSOURCE/ragusource-web'
        }
    ]
}
```

The apache.vhost node is a collection and multiple vhosts can be added.
