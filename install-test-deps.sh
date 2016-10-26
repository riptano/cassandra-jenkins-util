#!/bin/bash -xe

# fix default umask of 0002 for hadoop data dir errors
# export python-driver cython suppression env vars to all users (`sudo pip install ..` needs root to have this env, too)
sudo sh -c 'cat << EOF >> /etc/profile
umask 0022
export CASS_DRIVER_NO_CYTHON="true"
export CASS_DRIVER_NO_EXTENSIONS="true"
EOF'

# install some basic packages we need
sudo apt-get -y install ant ant-optional git libev-dev libyaml-dev lsof python-dev python-setuptools python-pip rsync screen wamerican
