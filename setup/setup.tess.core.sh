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

perl $TESSROOT/scripts/synonymy/build-trans-cache.pl --grc $TESSROOT/data/synonymy/g_l.csv

# word index
perl $TESSROOT/scripts/v3/add_column.pl --parallel $TESSNCORES \
    $TESSROOT/texts/la/*
perl $TESSROOT/scripts/v3/add_column.pl --parallel $TESSNCORES \
    $TESSROOT/texts/grc/*
perl $TESSROOT/scripts/v3/add_column.pl --parallel $TESSNCORES \
    $TESSROOT/texts/en/*


# stem index
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel $TESSNCORES \
    $TESSROOT/texts/la/*
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel $TESSNCORES \
    $TESSROOT/texts/grc/*
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel $TESSNCORES \
    --use-lingua $TESSROOT/texts/en/*

# trigram index
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel $TESSNCORES \
   --feat 3gr $TESSROOT/texts/la/*
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel $TESSNCORES \
   --feat 3gr $TESSROOT/texts/grc/*
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel $TESSNCORES \
   --feat 3gr $TESSROOT/texts/en/*

# translation index
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel $TESSNCORES \
   --feat trans $TESSROOT/texts/la/*
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel $TESSNCORES \
   --feat trans $TESSROOT/texts/grc/*

# calculate corpus stats
perl $TESSROOT/scripts/v3/corpus-stats.pl --feat stem --feat 3gr \
    --feat trans la grc
perl $TESSROOT/scripts/v3/corpus-stats.pl --feat stem --feat 3gr \
    --use-lingua en

# setup multi-text search
perl $TESSROOT/scripts/v3/index_multi.pl --lang la
perl $TESSROOT/scripts/v3/index_multi.pl --lang grc
perl $TESSROOT/scripts/v3/index_multi.pl --lang en --use-lingua