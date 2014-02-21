# Vagrant + Chef

Created: 10 Jan 2014

Author:  Roger Ragulan Rajaratnam <roger@ragusource.com>

Website: http://ragusource.com

Current release: 0.1.1

## Check out the project

```bash
$ git clone git@bitbucket.org:ragusource/vagrant.git
$ cp Vagrantfile.dist Vagrantfile #edit as required
$ vagrant up
```

## Add a virtual host
Open the Vagrantfile and edit the ansible.extra_vars hash so that the apache node looks like this:
```json
'apache' => {
    'nfs' => true,
    'vhosts' => [
        "server_name" => 'example.dev',
        "document_root" => '/var/www/example.dev/public',
        "nfs_mount" => '10.0.0.1:/Volumes/Development/RAGUSOURCE/ragusource-web'
    ]
}
```
The apache.vhost node is a collection and multiple vhosts can be added.
