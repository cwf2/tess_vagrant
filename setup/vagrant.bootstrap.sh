#!/usr/bin/env bash

set -x

. /vagrant/setup/tessrc

# get necessary packages

apt-get update

apt-get install -y \
	git                 \
   nginx               \
   fcgiwrap            \
   libfcgi-perl        \
	screen              \
	vim                 \
	htop                \
	perl-doc            \
	sqlite3             \
   beanstalkd          \
   make                \
   cpanminus           \
	libfile-copy-recursive-perl \
	libparallel-forkmanager-perl \
	liblingua-stem-perl \
	libdbd-sqlite3-perl \
   libarchive-zip-perl \
	libjson-perl        \
	libxml-libxml-perl  \
	libgit-repository-perl \
   python-numpy        \
   python-scipy        \
   python-pip

pip install gensim
cpanm Beanstalk::Client

cp /vagrant/setup/beanstalkd /etc/default/beanstalkd
service beanstalkd restart

# setup tesserae

#sudo -u vagrant git clone -b valery https://github.com/cwf2/tesserae $TESSROOT

#sudo -u vagrant /vagrant/setup/setup.tess.core.sh

#sudo -u vagrant /vagrant/setup/setup.apache.sh
