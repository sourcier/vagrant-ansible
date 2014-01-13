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

unless node['apache']['vhosts'].nil?
    node['apache']['vhosts'].each do |vhost|
        template "/etc/apache2/sites-enabled/#{vhost['server_name']}" do
            source "vhost.erb"
            variables(
                "server_name" => vhost['server_name'],
                "document_root" => vhost['doc_root'],
                "log_root" => node['apache']['log_root']
            )
            notifies :restart, "service[apache2]"
            mode 0644
        end
    end
end
