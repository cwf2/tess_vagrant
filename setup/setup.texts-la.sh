#!/usr/bin/env bash
. /vagrant/setup/tessrc
set -x

# word index
perl $TESSROOT/scripts/v3/add_column.pl --parallel $TESSNCORES $TESSROOT/texts/la/*

# stem index
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel $TESSNCORES $TESSROOT/texts/la/*

# trigram index
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel $TESSNCORES \
   --feat 3gr $TESSROOT/texts/la/*

# add to corpus stats
perl $TESSROOT/scripts/v3/corpus-stats.pl --feat stem --feat 3gr la

# add to dropdown menu
perl $TESSROOT/scripts/textlist.pl la

