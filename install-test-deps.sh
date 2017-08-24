#!/bin/bash -xe

# fix default umask of 0002 for hadoop data dir errors
sudo sh -c 'echo "umask 0022" >> /etc/profile'
# set python-driver cython suppression env vars for all users
#  `sudo pip install ..` needs root to have this env, too, and the sudoers env_reset won't pull this from /etc/profile
sudo sh -c 'cat << EOF >> /etc/environment
CASS_DRIVER_NO_CYTHON="true"
CASS_DRIVER_NO_EXTENSIONS="true"
EOF'

# install some basic packages we need
sudo apt-get -y install ant ant-optional git libaio1 libev-dev libyaml-dev lsof python-dev python-setuptools python-pip rsync screen wamerican

# work around failing DNS queries for github.com, since they switched to a 60sec TTL
# - min-cache-ttl max is 1hr and requires dnsmasq >= 2.73, which is available on Ubuntu 16.04 (Xenial) and Debian 9 (Stretch)
sudo apt-get -y install dnsmasq resolvconf
sudo sh -c 'echo min-cache-ttl=3600 >> /etc/dnsmasq.conf'
sudo service dnsmasq restart
