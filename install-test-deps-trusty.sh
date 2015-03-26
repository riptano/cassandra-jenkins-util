#!/bin/sh -xe
sudo apt-get update -q2
sudo apt-get -y install ant ant-optional libev-dev libyaml-dev python-dev python-setuptools wamerican
sudo pip install blist cassandra-driver cql decorator futures nose-test-select pycassa
git clone https://github.com/pcmanus/ccm.git
sudo pip install -e ccm
