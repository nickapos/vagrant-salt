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

# Chef salt 1-1 comparison
#Questions?
