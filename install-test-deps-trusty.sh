#!/bin/bash -xe
# fix default umask of 0002 for hadoop data dir errors
sudo sh -c 'echo "umask 0022" >> /etc/profile'

# install some basic packages we need
sudo apt-get -y install ant ant-optional git libev-dev libyaml-dev lsof python-dev python-setuptools python-pip rsync screen wamerican
# install some python modules that we need
sudo pip install blist cql decorator flaky futures nose-test-select pycassa
# install/upgrade the latest cassandra-driver in pypi, including pre-releases
sudo pip install --pre --upgrade cassandra-driver
# ..use the latest ccm HEAD
git clone https://github.com/pcmanus/ccm.git
sudo pip install -e ccm
