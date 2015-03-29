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
> - chef ohai -> salt grains
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

# Salt state files layout

> - Salt excepts a salt directory and a minion file in that
> - It also expects a directory named roots and a file named top.sls in it
> - top.sls is the root of all the state files
    * it defines what kind of environment exists
    * which sls files are included in which environment
    * the order by which these sls files are goind to be included
> - in roots directory we can find any number of sls files, or directories of sls files, the usage of which are defined in top.sls

# top.sls content

    base:
      '*':
        - common-tools
        - httpd.apache
        - dovecot.dovecot
        - bind.bind
        - db.mysql
        - db.postgres
        - supervisord.supervisord


# Sls file format
> - Sls files, can include other sls files forming thus a tree. The shape of the tree is fully defined by the developer
> - Sls files contain mostly YAML, but can also contain Jinla expressions
> - Sls file entries are separated in execution blocks that are consisted of
    * a unique block id
    * a number of salt modules statements
> - The different execution blocks in an sls file are executed sequentially

# typical sls file

    mysql:
      pkg:
        - installed

    mysql-server:
      pkg:
        - installed
      service:
        - name: mysqld
        - running

# sls example with custom commands and file transfer

    supervisor:
      cmd.run:
        - cwd: /
        - user: root
        - name: pip install supervisor
        - env:
          LC_ALL: C.UTF-8

    supervisor-init-file:
      file.managed:
        - name: /etc/init.d/supervisor
        - source: salt://supervisord/supervisor
        - user: root
        - group: root
        - mode: 755

# jinja attribute file example

    {% set pg_version = salt['grains.filter_by']({
        'CentOs' : { 'id': '8.4' },
        'RedHat' : { 'id': '9.1' },
        'Arch'   : { 'id': '9.1' },
        'Debian' : { 'id': '9.3' },
    }, merge=salt['grains.filter_by']({
        '14.04'  : { 'id': '9.3' },
        '14.10'  : { 'id': '9.4' },
    }, grain='lsb_distrib_release', merge=salt['grains.filter_by']({
        'jessie' : { 'id': '9.4' },
        'wheezy' : { 'id': '9.1' },
    }, grain='lsb_distrib_codename', merge=salt['pillar.get']('postgres:lookup')))) %}

# Execution and pitfalls

> - The usual command: _vagrant up_ will start the vm build
> - The vagrant-salt plugin provides the necessary vagrant/salt integration
> - Salt always does a full upgrade of the vm before the provisioning
> - After salt has been installed, the logs can be found in /var/log/salt
> - a yaml parser and verifier can save you hours of debugging
> - sometimes salt fails silently, the verifier may help with that
> - there seems to be a bug in the auto bootstrap script that affects centos 7 provisioning


#Questions?
