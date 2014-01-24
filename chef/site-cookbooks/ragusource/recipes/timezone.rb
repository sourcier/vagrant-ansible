#
# Cookbook Name:: ragusource
# Recipe:: timezone

execute 'set-timezone' do
    action :run
    command "sudo echo #{node['timezone']} > /etc/timezone"
    notifies :run, 'execute[update-tzdata]'
    not_if "grep \"#{node['timezone']}\" /etc/timezone"
end
execute 'update-tzdata' do
    command 'sudo dpkg-reconfigure -f noninteractive tzdata'
    action :nothing
end
