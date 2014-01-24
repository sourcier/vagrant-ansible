#
# Cookbook Name:: ragusource
# Recipe:: mysql

package 'mysql-server' do
    action :install
    notifies :run, 'execute[mysql-set-root-password]'
end

service 'mysql' do
    action :enable
    restart_command 'sudo service mysql restart'
end

execute 'mysql-set-root-password' do
    action :nothing
    command "mysqladmin -u root password #{node['mysql']['root_pass']}"
    notifies :run, 'execute[mysql-enable-remote-login]'
end

execute 'mysql-enable-remote-login' do
    action :nothing
    command "mysql --user=root --password=#{node['mysql']['root_pass']} -e \"GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '#{node['mysql']['root_pass']}' WITH GRANT OPTION;\""
    notifies :restart, 'service[mysql]'
end

template 'mysql-config' do
    path '/etc/mysql/my.cnf'
    source 'mysql.erb'
    variables(
        'bind_ip' => node['mysql']['bind_ip']
    )
    notifies :restart, 'service[mysql]'
    mode 0644
end
