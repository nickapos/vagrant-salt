# -*- mode: ruby -*-"
# vi: set ft=ruby :

box_type  = "chef/centos-6.6"

Vagrant.configure("2") do |config|
  config.vm.box = "#{box_type}"
  config.berkshelf.enabled = true

 ## Use all the defaults:
  config.vm.provision :salt do |salt|

    salt.minion_config = "salt/minion"
    salt.run_highstate = true

  end
end
