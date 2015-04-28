#!/usr/bin/env bash
. /vagrant/setup/tessrc
set -x

#
# set up tesserae
#

perl $TESSROOT/scripts/v3/build-stem-cache.pl grc

# word index
perl $TESSROOT/scripts/v3/add_column.pl --parallel 2 texts/grc/*

# stem index
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel 2 texts/grc/*

# trigram index
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel 2 --feat 3gr texts/grc/*

perl $TESSROOT/scripts/v3/corpus-stats.pl --feat stem --feat 3gr la grc

# drop down lists
perl $TESSROOT/scripts/v3/textlist.pl grc
