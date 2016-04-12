#!/usr/bin/env bash

set -x

. /vagrant/setup/tessrc

# get necessary packages

apt-get update

apt-get install -y \
	git                 \
	apache2             \
	screen              \
	vim                 \
	htop                \
	perl-doc            \
	sqlite3             \
	libapache2-mod-php5 \
	libfile-copy-recursive-perl \
	libparallel-forkmanager-perl \
	liblingua-stem-perl \
	libdbd-sqlite3-perl \
   libarchive-zip-perl \
	libjson-perl        \
	libxml-libxml-perl  \
	libgit-repository-perl \
#   python-numpy        \
#   python-scipy        \
#   python-pip
#
# pip install gensim


# download tesserae - if it doesn't exist already

if ! [ -e $TESSROOT ]
then
  sudo -u vagrant git clone -b develop https://github.com/tesserae/tesserae $TESSROOT
fi

/vagrant/setup/setup.cut-texts.sh
/vagrant/setup/setup.tess.core.sh
/vagrant/setup/setup.texts-la.sh
/vagrant/setup/setup.texts-grc.sh
/vagrant/setup/setup.texts-en.sh
/vagrant/setup/setup.apache.sh
