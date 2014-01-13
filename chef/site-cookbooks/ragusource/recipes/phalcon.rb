#
# Cookbook Name:: ragusource
# Recipe:: phalcon

package 'php5-dev'
package 'php5-mysql'
package 'gcc'

execute "clone-phalcon" do
    action :run
    command "git clone --depth=1 git://github.com/phalcon/cphalcon.git"
    cwd "/home/vagrant"
    not_if { File.exist?('/home/vagrant/cphalcon') }
    notifies :run, "execute[build-phalcon]"
end

execute "build-phalcon" do
    command "sudo ./install"
    action :nothing
    cwd "/home/vagrant/cphalcon/build"
    notifies :create, "template[phalcon-apache]"
    notifies :create, "template[phalcon-cli]"
end

template "phalcon-apache" do
    action :nothing
    source "phalcon.erb"
    path "/etc/php5/apache2/conf.d/20-phalcon.ini"
    notifies :restart, "service[apache2]"
    mode 0644
end

template "phalcon-cli" do
    action :nothing
    source "phalcon.erb"
    path "/etc/php5/cli/conf.d/20-phalcon.ini"
    mode 0644
end
