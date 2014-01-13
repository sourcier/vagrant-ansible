#
# Cookbook Name:: ragusource
# Recipe:: apache

package 'apache2'

service "apache2" do
    action :enable
end

execute "sudo a2enmod rewrite" do
    notifies :restart, "service[apache2]"
end

template "/etc/apache2/sites-enabled/20-booyah.conf" do
    source "vhost.erb"
    variables(
        "server_name" => 'booyah.dev',
        "document_root" => '/vagrant/workspace/public',
        "log_root" => '/vagrant/logs'
    )
    notifies :restart, "service[apache2]"
    mode 0644
end
