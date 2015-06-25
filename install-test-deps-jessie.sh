#!/bin/bash -xe
# fix default umask of 0002 for hadoop data dir errors
sudo sh -c 'echo "umask 0022" >> /etc/profile'

# which jdk do we have?
java -version

# install some basic packages we need
sudo apt-get -y install ant ant-optional git libev-dev libyaml-dev lsof python-dev python-setuptools python-pip rsync screen wamerican
# install some python modules that we need
sudo pip install blist cassandra-driver cql decorator futures nose-test-select pycassa
# ..use the latest ccm HEAD
git clone https://github.com/pcmanus/ccm.git
sudo pip install -e ccm
