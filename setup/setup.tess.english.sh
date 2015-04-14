#!/usr/bin/env bash
. /vagrant/setup/tessrc
set -x

#
# set up tesserae
#

perl $TESSROOT/scripts/configure.pl --url_root 'master.tesserae.org'
perl $TESSROOT/scripts/install.pl

perl $TESSROOT/scripts/v3/build-stem-cache.pl la grc
perl $TESSROOT/scripts/v3/patch-stem-cache.pl

# word index
perl $TESSROOT/scripts/v3/add_column.pl --parallel 2 texts/la/*
perl $TESSROOT/scripts/v3/add_column.pl --parallel 2 texts/grc/*
perl $TESSROOT/scripts/v3/add_column.pl --parallel 2 texts/en/*

# stem index
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel 2 texts/la/*
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel 2 texts/grc/*
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel 2 --use-lingua-stem texts/en/*

# trigram index
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel 2 --feat 3gr texts/la/*
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel 2 --feat 3gr texts/grc/*
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel 2 --feat 3gr texts/en/*

perl $TESSROOT/scripts/v3/corpus-stats.pl --feat stem --feat 3gr la grc en

# drop down lists
perl $TESSROOT/scripts/v3/textlist.pl en
