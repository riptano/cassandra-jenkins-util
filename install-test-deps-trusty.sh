#!/bin/sh -xe
sudo apt-get update -q2
sudo apt-get -y install ant ant-optional libev-dev libyaml-dev python-dev python-setuptools wamerican
sudo pip install blist cassandra-driver ccm cql decorator futures nose-test-select pycassa
