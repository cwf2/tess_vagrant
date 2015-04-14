#!/usr/bin/env bash
. /vagrant/setup/tessrc
set -x

#
# reduce corpus to just a few representative texts
#

cd $TESSROOT

rm -rf texts

git checkout texts/la/vergil.aeneid.tess
git checkout texts/la/vergil.aeneid
git checkout texts/la/lucan.bellum_civile.tess
git checkout texts/la/lucan.bellum_civile

git checkout texts/grc/homer.iliad.tess
git checkout texts/grc/homer.iliad
git checkout texts/grc/apollonius.argonautica.tess
git checkout texts/grc/apollonius.argonautica

git checkout texts/en/wordsworth.prelude.tess
git checkout texts/en/wordsworth.prelude
git checkout texts/en/cowper.task.tess
git checkout texts/en/cowper.task

