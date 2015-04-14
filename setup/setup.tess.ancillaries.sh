#!/usr/bin/env bash
. /vagrant/setup/tessrc
set -x


# setup lsi search
perl $TESSROOT/scripts/lsa/lsa.samples.pl $TESSROOT/texts/la/*
python $TESSROOT/scripts/lsa/lsa.train.py $TESSROOT/texts/la/*

# setup multi-text search
perl $TESSROOT/scripts/v3/index_multi.pl --lang la
perl $TESSROOT/scripts/v3/index_multi.pl --lang grc

# create translation dictionaries
# - trans1
perl $TESSROOT/scripts/synonymy/cross-language-dictionary-gen.pl \
   --grc $TESSROOT/data/synonymy/grc.nt_parallel.tess \
   --la $TESSROOT/data/synonymy/la.nt_parallel.tess \
   --feat trans1
perl $TESSROOT/scripts/synonymy/build-trans-cache.pl \
   --grc $TESSROOT/data/synonymy/trans1.csv \
   --feat trans1
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel 2 \
   --feat trans1 $TESSROOT/texts/la/*
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel 2 \
   --feat trans1 $TESSROOT/texts/grc/*
perl $TESSROOT/scripts/v3/corpus-stats.pl --feat trans1 la grc
# -trans2
python $TESSROOT/scripts/synonymy/read_lexicon.py -m tess -n 10
python $TESSROOT/scripts/synonymy/sims-export.py -t 1 -w -n 2 -f trans2
perl $TESSROOT/scripts/synonymy/build-trans-cache.pl \
   --grc $TESSROOT/data/synonymy/trans2.csv \
   --feat trans2
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel 2 \
   --feat trans2 $TESSROOT/texts/la/*
perl $TESSROOT/scripts/v3/add_col_stem.pl --parallel 2 \
   --feat trans2 $TESSROOT/texts/grc/*
perl $TESSROOT/scripts/v3/corpus-stats.pl --feat trans2 la grc

# setup batch daemon
perl $TESSROOT/scripts/batch/build-queue.pl
screen -S batch -d -m perl $TESSROOT/scripts/batch/batch.manage.pl
