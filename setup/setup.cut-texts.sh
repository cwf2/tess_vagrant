#!/usr/bin/env bash
. /vagrant/setup/tessrc
set -x

#
# reduce corpus to just a few representative texts
#

OLDDIR=`pwd`
cd $TESSROOT

# latin

rm -rf texts/la

git checkout texts/la/vergil.aeneid.tess
git checkout texts/la/vergil.aeneid
git checkout texts/la/lucan.bellum_civile.tess
git checkout texts/la/lucan.bellum_civile

# greek

rm -rf texts/grc

git checkout texts/grc/homer.iliad.tess
git checkout texts/grc/homer.iliad
git checkout texts/grc/apollonius.argonautica.tess
git checkout texts/grc/apollonius.argonautica

# english

rm -rf texts/en

git checkout texts/en/wordsworth.prelude.tess
git checkout texts/en/wordsworth.prelude
git checkout texts/en/cowper.task.tess
git checkout texts/en/cowper.task

cd $OLDDIR
