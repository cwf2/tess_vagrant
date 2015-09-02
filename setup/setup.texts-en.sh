#!/usr/bin/env bash
. /vagrant/setup/tessrc
set -x

# word index
perl $TESSROOT/scripts/v3/add_column.pl --parallel $TESSNCORES $TESSROOT/texts/en/*

# stem index
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel $TESSNCORES --use-lingua-stem $TESSROOT/texts/en/*

# trigram index
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel $TESSNCORES \
   --feat 3gr $TESSROOT/texts/en/*

# add to corpus stats
perl $TESSROOT/scripts/v3/corpus-stats.pl --feat stem --feat 3gr en

# add to dropdown menu
perl $TESSROOT/scripts/textlist.pl en
