#!/usr/bin/env bash
. /vagrant/setup/tessrc
set -x


# setup lsi search
perl $TESSROOT/scripts/lsa/lsa.samples.pl --train --parallel $TESSNCORES \
    $TESSROOT/texts/la/*

# setup batch daemon
perl $TESSROOT/scripts/batch/build-queue.pl
screen -S batch -d -m perl $TESSROOT/scripts/batch/batch.manage.pl
