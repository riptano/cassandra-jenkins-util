#!/bin/bash -xe

# Set default arguments if not passed
CCM_REPO=${1:-pcmanus}
CCM_BRANCH=${2:-master}

# fix default umask of 0002 for hadoop data dir errors
sudo sh -c 'echo "umask 0022" >> /etc/profile'
# remove ctool-installed maven config, so we're using cassandra's preferred upstreams
rm -f ~/.m2/settings.xml

# install some basic packages we need
sudo apt-get -y install ant ant-optional git libev-dev libyaml-dev lsof python-dev python-setuptools python-pip rsync screen wamerican
# install some python modules that we need
sudo pip install --upgrade cql decorator docopt enum34 flaky futures nose nose-test-select parse pep8 psutil pycassa xunitmerge
# install/upgrade the latest cassandra-driver in pypi, including pre-releases
#sudo pip install --pre --upgrade cassandra-driver
# install python-driver from cassandra-test branch - this branch will get releases merged, as well as unreleased dev features
git clone -b cassandra-2.0.17_pydriver-sha https://github.com/mshuler/python-driver.git
sudo pip install -e python-driver
# ..use the latest ccm HEAD
git clone -b $CCM_BRANCH https://github.com/$CCM_REPO/ccm.git
sudo pip install -e ccm

# where and what version are we using?
which nosetests
nosetests --version
