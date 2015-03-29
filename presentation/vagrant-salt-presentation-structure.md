---
title: Infrastructure automation with python
author: Nick Apostolakis
date: 03 of April 2015
output:
  slidy_presentation:
    incremental: true
---


# Technology recap

## _[Vagrant](https://www.vagrantup.com/)_
> - a tool for building complete virtualized environments.
> - supports lots of different virtualization backends
    * Virtualbox (the default)
    * VmWare
> - supports lots of different provisioning backends:
    * shell
    * chef
    * salt
    * ansible
    * powershell
> - platform independent
    * windows
    * linux

## _[Saltstack](http://saltstack.com/)_
> - systems management tool. can be usef for:
    * configuration management
    * systems orchestration
> - written in python
> - supports all operation modes and more:
    * masterless mode
    * master/minions mode
    * one off custom command execution either to whole minions environment, or to isolated minions (ansible, capistrano)
> - uses extensively YAML
> - supports templating

# Chef salt 1-1 comparison
> - chef recipe -> salt state
> - chef resource -> salt state module
> - chef attributes/databags -> salt pillars
> - chef cookbook -> salt formula
> - chef uses ruby DSL -> salt uses YAML and Jinja
> - chef can be extended with ruby -> salt can be extended with python

# Chef salt architectural differences

> - Chef enforces a specific workflow. The cookbooks have a strictly defined structure, and the relationship of cookbooks is also strictly defined
> - Salt does not enforce a specific workflow. Its formulas structure does not follow a specific pattern, but they can be structured in a loosely defined tree. 

# _[Vagrant - salt integration](https://github.com/nickapos/vagrant-salt)_

    box_type  = "chef/centos-6.6"
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

# Masterless mode

is defined by a:

> - "salt/minion" file with contents
    * file_client: local
> - it defines the filesystem backend used by salt.
> - other backends are:
    * salt server backend
    * gitfs backend
> - gitfs backend is the chosen method for community formula distribution
> - is unsupported by masterless mode
> - setting highstate to true, is the salt way to start converging the minion


#Questions?
