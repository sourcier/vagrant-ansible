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
    not_if "test -d /home/vagrant/cphalcon"
    notifies :run, "execute[checkout-phalcon-tag]"
end

execute "checkout-phalcon-tag" do
    command "git checkout tags/v#{node['phalcon']['version']}"
    cwd "/home/vagrant/cphalcon"
    notifies :run, "execute[build-phalcon]"
end

execute "build-phalcon" do
    action :nothing
    command "sudo ./install"
    cwd "/home/vagrant/cphalcon/build"
    notifies :create, "template[phalcon-apache]"
    notifies :create, "template[phalcon-cli]"
    not_if "php --ri phalcon | grep #{node['phalcon']['version']}"
end

template "phalcon-apache" do
    action :nothing
    source "phalcon.erb"
    path "/etc/php5/apache2/conf.d/20-phalcon.ini"
    notifies :restart, "service[apache2]", :immediately
    mode 0644
end

template "phalcon-cli" do
    action :nothing
    source "phalcon.erb"
    path "/etc/php5/cli/conf.d/20-phalcon.ini"
    mode 0644
end
