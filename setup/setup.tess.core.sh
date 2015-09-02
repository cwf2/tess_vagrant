#!/usr/bin/env bash
. /vagrant/setup/tessrc
set -x

#
# set up tesserae
#

if ! [ -e $TESSTMP ]
then
   mkdir $TESSTMP
fi

perl $TESSROOT/scripts/configure.pl --url_root $TESSDOMAIN --fs_tmp $TESSTMP
perl $TESSROOT/scripts/install.pl

perl $TESSROOT/scripts/build-stem-cache.pl la grc
perl $TESSROOT/scripts/patch-stem-cache.pl

