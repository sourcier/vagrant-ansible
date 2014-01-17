#
# Cookbook Name:: ragusource
# Recipe:: php

package 'php5'
package 'php5-mysql'
package 'php5-xdebug'

template '/etc/php5/apache2/php.ini' do
    action :create
    source 'php.erb'
    mode 0644
    variables(:options => node['php']['options'])
end
template '/etc/php5/cli/php.ini' do
    action :create
    source 'php.erb'
    mode 0644
    variables(:options => node['php']['options'])
end
