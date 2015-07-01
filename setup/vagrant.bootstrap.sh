#!/usr/bin/env bash

set -x

TESSROOT="/home/vagrant/tesserae"
TESSTMP="/home/vagrant/tess-session"
TESSDOMAIN="stace.tesserae.org"
TESSNCORES=2

# get necessary packages

apt-get install -y \
	git                 \
	apache2             \
	htop                \
    libapache2-mod-perl2 \
	libapache2-mod-php5 \
	libfile-copy-recursive-perl \
	libparallel-forkmanager-perl \
	liblingua-stem-perl \
	libjson-perl        \
	libxml-libxml-perl  \
	libgit-repository-perl \


# setup tesserae

git clone -b unige.ach.2015 https://github.com/cwf2/tesserae $TESSROOT

if ! [ -e $TESSTMP ]
then
   mkdir $TESSTMP
fi

perl $TESSROOT/scripts/configure.pl --url_root $TESSDOMAIN --fs_tmp $TESSTMP
perl $TESSROOT/scripts/install.pl

perl $TESSROOT/scripts/v3/build-stem-cache.pl
perl $TESSROOT/scripts/v3/patch-stem-cache.pl

# word index
perl $TESSROOT/scripts/v3/add_column.pl --parallel $TESSNCORES $TESSROOT/texts/la/*

# stem index
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel $TESSNCORES $TESSROOT/texts/la/*

# trigram index
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel $TESSNCORES \
   --feat 3gr $TESSROOT/texts/la/*

perl $TESSROOT/scripts/v3/corpus-stats.pl --feat stem --feat 3gr la


#
# configure web server
#

perl $TESSROOT/scripts/apache2/vhost-gen.pl > /tmp/tesserae.conf
mv /tmp/tesserae.conf /etc/apache2/sites-available/
a2ensite tesserae
service apache2 restart

chgrp -R www-data $TESSTMP
chmod g+w $TESSTMP

# build dropdown lists
perl $TESSROOT/scripts/v3/textlist.pl la
