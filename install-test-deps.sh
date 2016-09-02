#!/bin/bash -xe

# fix default umask of 0002 for hadoop data dir errors
sudo sh -c 'echo "umask 0022" >> /etc/profile'

# install some basic packages we need
sudo apt-get -y install ant ant-optional git libev-dev libyaml-dev lsof python-dev python-setuptools python-pip rsync screen wamerican
