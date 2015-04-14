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

perl $TESSROOT/scripts/v3/build-stem-cache.pl la grc
perl $TESSROOT/scripts/v3/patch-stem-cache.pl

# word index
perl $TESSROOT/scripts/v3/add_column.pl --parallel $TESSNCORES $TESSROOT/texts/la/*
perl $TESSROOT/scripts/v3/add_column.pl --parallel $TESSNCORES $TESSROOT/texts/grc/*

# stem index
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel $TESSNCORES $TESSROOT/texts/la/*
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel $TESSNCORES $TESSROOT/texts/grc/*

# trigram index
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel $TESSNCORES \
   --feat 3gr $TESSROOT/texts/la/*
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel $TESSNCORES \
   --feat 3gr $TESSROOT/texts/grc/*

perl $TESSROOT/scripts/v3/corpus-stats.pl --feat stem --feat 3gr la grc
