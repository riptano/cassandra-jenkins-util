#!/bin/bash -xe
# fix default umask of 0002 for hadoop data dir errors
sudo sh -c 'echo "umask 0022" >> /etc/profile'

# add jdk and backports repos, install oracle 7/8 and openjdk 7/8
wget -O - http://12.am/jdk/repo-pub.key | sudo apt-key add -
sudo sh -c 'echo "deb http://12.am/jdk/ unstable non-free" >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://http.debian.net/debian/ jessie-backports main" >> /etc/apt/sources.list'
sudo apt-get update -q2
sudo apt-get -y --no-install-recommends install oracle-java7-jdk oracle-java8-jdk openjdk-7-jdk openjdk-8-jdk
sudo sh -c 'echo "export JAVA7_HOME=/usr/lib/jvm/java-7-oracle" >> /etc/profile'
sudo sh -c 'echo "export JAVA8_HOME=/usr/lib/jvm/java-8-oracle" >> /etc/profile'
sudo sh -c 'echo "export OPENJDK7_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64" >> /etc/profile'
sudo sh -c 'echo "export OPENJDK8_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64" >> /etc/profile'
# set default JDK
if [[ "$JDK_VERSION" = 1.7_* ]]; then
    if [ -n "$USE_OPENJDK" ]; then
        sudo update-java-alternatives --set java-1.7.0-openjdk-amd64
    else
        sudo update-java-alternatives --set java-7-oracle
    fi
elif [[ "$JDK_VERSION" = 1.8_* ]]; then
    if [ -n "$USE_OPENJDK" ]; then
        sudo update-java-alternatives --set java-1.8.0-openjdk-amd64
    else
        sudo update-java-alternatives --set java-8-oracle
    fi
else
    # if passed no versions, set oracle jdk-7 as default, otherwise we get openjdk-7
    sudo update-java-alternatives --set java-7-oracle
fi

# which jdk do we have?
java -version

# install some basic packages we need
sudo apt-get -y install ant ant-optional git libev-dev libyaml-dev lsof python-dev python-setuptools python-pip rsync screen wamerican
# install some python modules that we need
sudo pip install blist cassandra-driver cql decorator futures nose-test-select pycassa
# ..use the latest ccm HEAD
git clone https://github.com/pcmanus/ccm.git
sudo pip install -e ccm
