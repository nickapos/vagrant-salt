# -*- mode: ruby -*-"
# vi: set ft=ruby :

box_type  = "chef/centos-6.6"
#box_type  = "chef/centos-7.0"
#box_type  = "ubuntu/trusty64"

Vagrant.configure("2") do |config|
  config.vm.box = "#{box_type}"
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 1
  end
  
  # For masterless, mount your salt file root
  config.vm.synced_folder "salt/roots/", "/srv/salt/"
  
  ## Use all the defaults:
  config.vm.provision :salt do |salt|

    salt.minion_config = "salt/minion"
    salt.run_highstate = true

  end
end
