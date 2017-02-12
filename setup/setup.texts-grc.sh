#!/usr/bin/env bash
. /vagrant/setup/tessrc
set -x

# word index
perl $TESSROOT/scripts/v3/add_column.pl --parallel $TESSNCORES $TESSROOT/texts/grc/*

# stem index
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel $TESSNCORES $TESSROOT/texts/grc/*

# trigram index
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel $TESSNCORES \
   --feat 3gr $TESSROOT/texts/grc/*

# add to corpus stats
perl $TESSROOT/scripts/v3/corpus-stats.pl --feat stem --feat 3gr grc

# add to dropdown menu
perl $TESSROOT/scripts/textlist.pl grc
