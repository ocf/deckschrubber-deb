#!/bin/bash
set -euxo pipefail

git clone --branch $DECKSCHRUBBER_TAG https://github.com/fraunhoferfokus/deckschrubber.git /tmp/deckschrubber
cd /tmp/deckschrubber

go get -v

# Build the .deb and put it in /mnt, which is mounted from dist_*/ in the Makefile.
cd /mnt
fpm -s dir -t deb \
    -n deckschrubber \
    -v $(echo $DECKSCHRUBBER_TAG | sed 's/[^0-9.]*//g')+deb$(lsb_release -rs | cut -d . -f 1)u1~ocf1 \
    --deb-generate-changes \
    --deb-dist $DIST_TAG \
    --description "Deckschrubber inspects images of a Docker Registry and removes those older than a given age." \
    --url "https://github.com/ocf/deckschrubber-deb" \
    --maintainer "root@ocf.berkeley.edu" \
    --force \
    $GOBIN/deckschrubber=/usr/bin/
