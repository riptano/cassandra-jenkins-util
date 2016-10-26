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
sudo apt-get -y install ant ant-optional git libev-dev libyaml-dev lsof python-dev python-setuptools python-pip rsync screen wamerican
