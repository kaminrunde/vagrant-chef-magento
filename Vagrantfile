# -*- mode: ruby -*-
# vi: set ft=ruby :

# Setup a TLD for the box
# !!!! REQUIRES !!!!! A: sudo vagrant dns --install OR rvmsudo vagrant dns --install (for rvm users) to make it work !!!!
# box_tld="devel"

Vagrant::Config.run do |config|

  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.host_name = "magento.local"

  # more memory for the VM
  config.vm.customize ["modifyvm", :id, "--memory", 512]
  
  # configure the TLD
  # config.dns.tld = box_tld
  # config.dns.patterns = [/^.*.#{box_tld}$/]
  # !!!! use: rvmsudo vagrant dns --install

  config.vm.network :hostonly, "192.168.13.37"

  # Use symbilic links
  # config.vm.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]

  # NFS Folders ncomment for better performance (NOT AVAILABLE on Windows-Systems)
  # config.vm.share_folder "v-root", "/vagrant", ".", :nfs => true

  config.vm.provision :chef_solo do |chef|
    # Tell chef what recipe to run. In this case, the `main` recipe does all the magic.
    chef.add_recipe("main")     

    # You may also specify custom JSON attributes:
    chef.json = {
      #'tld' => box_tld,
      'vhost_root' => "/vagrant/sites/default",
      'magento' => {
        'db_user' => "root",
        'db_password' => "vagrant",
        'db_name' => "magedev_db",
        'db_host' => "localhost",
        'db_source_dir' => "/vagrant/db_import",
        'db_source_file' => "magedev_db.sql",
        'admin_user' => {
          'firstname' => 'dev_admin',
          'lastname' => 'dev_admin',
          'username' => 'dev_admin',
          'email' => 'admin@kaminrun.de',
          'password' => 'password1'
        }
      },
      'apache' => {
          'prefork' => {
            'startservers' => 1,
            'minspareservers' => 1
          },
          'default_site_enabled' => false
        },
      # Override attributes here. Each cookbook will specify which attributes to override.
      "mysql" => {
        "server_root_password" => "vagrant",
        "server_repl_password" => "vagrant",
        "server_debian_password" => "vagrant"
      },
    }

  end
end
