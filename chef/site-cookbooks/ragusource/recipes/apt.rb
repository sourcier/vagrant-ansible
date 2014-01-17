#
# Cookbook Name:: ragusource
# Recipe:: apt

execute "update-apt" do
  command "sudo apt-get update"
  action :run
end

package 'python-software-properties'

# Add ppa:ondrej/php5 repo
execute 'sudo add-apt-repository -y ppa:ondrej/php5' do
  action :run
  not_if 'test -f /etc/apt/sources.list.d/ondrej-php5-precise.list'
  notifies :run, "execute[update-apt]", :immediately
end
