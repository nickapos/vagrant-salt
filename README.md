# vagrant-salt
A vagrant project with saltstack as the provisioner. It uses the community centos 6.6 as base box
and installs a number of packages, and installs and activates a number of services usually found on a server:
* Postfix
* ssh
* imap (dovecot)
* apache
* mysql
* postgresql
* pptpd
* nagios
* supervisord
* named
* fail2ban

## Vagrant plugins needed
* vagrant-salt
