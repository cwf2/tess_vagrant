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
    python-numpy        \
    python-scipy        \
    python-pip

pip install gensim

# setup tesserae

sudo -u vagrant git clone -b 3_1 https://github.com/cwf2/tesserae $TESSROOT
# comment out the line below to install the full corpus
sudo -u vagrant /vagrant/setup/setup.cut-texts.sh
sudo -u vagrant /vagrant/setup/setup.tess.core.sh

sudo -u vagrant /vagrant/setup/setup.apache.sh
