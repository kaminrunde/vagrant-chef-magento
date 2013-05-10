# vagrant-chef-magento

### toolset
* install oracle virtualbox: [https://www.virtualbox.org](https://www.virtualbox.org)
* install vagrant: [http://www.vagrantup.com](http://www.vagrantup.com)
* install git: [http://git-scm.com/downloads](http://git-scm.com/downloads)

### setup the application
* create an vagrant directory: {app_dir} (e.g. /home/users/me/vagrant)
* create an application directory: {app_dir} (e.g. /home/users/me/vagrant/sites/default)
* go to the {app_dir} and:
	* clone the vagrant-chef-magento
	* clone YOUR the mage-repo into {app_dir}/sites/default

# 
	git clone git@github.com:kaminrunde/vagrant-chef-magento.git {app_dir}
	git clone git@github.com:YOUR-MAGE/REPO.git {app_dir}/sites/default

# 
* copy your magento database into: {app_dir}/db_import/
* rename database-file to: magedev_db.sql
* => {app_dir}/db_import/magedev_db.sql (should exist)
				
### start vm
 - VM default ip is 192.168.13.37
 - make a local host entry (/etc/hosts or C:\Windows\system32\drivers\ets\hosts) for: 192.168.13.37 magento.local
 - ping magento.local (should work -> 192.168.13.37)
 - open a console
 - got to the {app_dir}
 - fire up your server: "vagrant up"
 - take a break -- this may take a while ;-)
 - point your browser to: http://magento.local
 - done .. gl ;-) 
 
 (Configuration Options see: Vagrantfile form the vagrant-chef-magento repo)
 
### reimport the database
remove the file {app_dir}/db_import/.imported

### mac users
uncomment the line:

	config.vm.share_folder "v-root", "/vagrant", ".", :nfs => true
 
 in the Vagrantfile for better performance
 
### example with sample data

setup a new magento:

	get sample data: http://www.magentocommerce.com/downloads/assets/1.6.1.0/magento-sample-data-1.6.1.0.zip

and extract the magento_sample_data_for_1.6.1.0.sql to db_import/magedev_db.sql

	get magento source http://www.magentocommerce.com/getmagento/1.7.0.2/magento-1.7.0.2.zip
	
and extract to {app_dir}/sites/default

	vagrant up
 
### hint for starting from production Magento db

Checkout the [wiki](https://github.com/kaminrunde/vagrant-chef-magento/wiki) for sql statement to clean production Magento from customer data.
