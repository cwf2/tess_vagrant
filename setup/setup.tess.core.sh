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

perl $TESSROOT/scripts/install/configure.pl --url_root $TESSDOMAIN --fs_tmp $TESSTMP
perl $TESSROOT/scripts/install/install.pl

# build stem cache
perl $TESSROOT/scripts/build-stem-cache.pl la grc
perl $TESSROOT/scripts/patch-stem-cache.pl

# build synyonymy caches
perl $TESSROOT/scripts/synonymy/build-trans-cache.pl --feat syn \
  --la $TESSROOT/data/synonymy/syn.csv \
  --grc $TESSROOT/data/synonymy/syn.csv
perl $TESSROOT/scripts/synonymy/build-trans-cache.pl --feat syn_lem \
  --la $TESSROOT/data/synonymy/syn_lem.csv \
  --grc $TESSROOT/data/synonymy/syn_lem.csv
perl $TESSROOT/scripts/synonymy/build-trans-cache.pl --feat g_l \
  --grc $TESSROOT/data/synonymy/g_l.csv

