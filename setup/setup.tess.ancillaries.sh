#!/usr/bin/env bash
. /vagrant/setup/tessrc
set -x


# setup lsi search
perl $TESSROOT/scripts/lsa/lsa.samples.pl --train --parallel $TESSNCORES \
    $TESSROOT/texts/la/*

# setup batch daemon
perl $TESSROOT/scripts/batch/build-queue.pl
screen -S batch -d -m perl $TESSROOT/scripts/batch/batch.manage.pl

# setup benchmarks
perl $TESSROOT/scripts/benchmark/build-rec.pl --bench default \
    --target lucan.bellum_civile.part.1 \
    --source vergil.aeneid \
    --unit phrase \
    --label "Lucan 1 - Aeneid" \
        $TESSROOT/data/bench/bench4.txt

perl $TESSROOT/scripts/benchmark/build-rec.pl --bench knauer \
    --target vergil.aeneid.part.1 \
    --source homer.iliad \
    --unit phrase \
    --label "Aeneid 1 - Iliad" \
        $TESSROOT/data/bench/aeneid1-iliad_include_uni_blank.txt
