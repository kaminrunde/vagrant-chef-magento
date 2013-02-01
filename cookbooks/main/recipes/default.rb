include_recipe "apt"    
include_recipe "build-essential"
include_recipe "mysql::server"    
include_recipe "mysql::client"    
include_recipe 'php'
include_recipe "apache2"    
include_recipe "apache2::mod_php5"  
include_recipe "phpmyadmin"

package "php5-mysql" do
  action :install
end

package "php5-mcrypt" do
  action :install
end

package "php5-curl" do
	action :install
end

directory node['vhost_root'] do
	mode 00755
	action :create
	recursive true
end

template "#{node['magento']['db_source_dir']}/mage_setup.sql" do
	node['mage_hostname'] = node['fqdn']
	node['mage_unsecure_hostname'] = "http://#{node['mage_hostname']}/"
	node['mage_secure_hostname'] = "https://#{node['mage_hostname']}/"
	source "mage_setup.sql.erb"
	mode 0644
end

template "#{node['vhost_root']}/app/etc/local.xml" do
	source "mage_local.xml.erb"
	mode 0644
end

web_app "100-magento-site" do
  server_name node['fqdn']
  server_aliases [node['fqdn'], node['hostname']]
  docroot node['vhost_root']
  template "default_site.conf.erb"
end

execute "mage db setup" do
  setup_commands = []
  setup_commands << "mysql -u #{node['magento']['db_user']} -h #{node['magento']['db_host']} --password='#{node['magento']['db_password']}' --execute 'DROP DATABASE IF EXISTS #{node['magento']['db_name']}'"
  setup_commands << "mysql -u #{node['magento']['db_user']} -h #{node['magento']['db_host']} --password='#{node['magento']['db_password']}' --execute 'CREATE DATABASE IF NOT EXISTS #{node['magento']['db_name']}'"
  setup_commands << "mysql -u #{node['magento']['db_user']} -h #{node['magento']['db_host']} --password='#{node['magento']['db_password']}' #{node['magento']['db_name']} < #{node['magento']['db_source_dir']}/#{node['magento']['db_source_file']}"
  setup_commands << "mysql -u #{node['magento']['db_user']} -h #{node['magento']['db_host']} --password='#{node['magento']['db_password']}' #{node['magento']['db_name']} < #{node['magento']['db_source_dir']}/mage_setup.sql && touch #{node['magento']['db_source_dir']}/.imported"
  command setup_commands.join(";")
  creates "#{node['magento']['db_source_dir']}/.imported"
  action :run
end