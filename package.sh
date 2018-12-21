#!/bin/bash
set -euxo pipefail

git clone --branch $DECKSCHRUBBER_TAG https://github.com/fraunhoferfokus/deckschrubber.git /tmp/deckschrubber
cd /tmp/deckschrubber

# go needs places to put its build files, and the built binaries.
mkdir /tmp/go
export GOPATH=/tmp/go

mkdir -p /tmp/build/bin
export GOHOME=/tmp/build
export GOBIN=/tmp/build/bin

go get -v

# Build the .deb and put it in /mnt, which is mounted from dist_*/ in the Makefile.
cd /mnt
fpm -s dir -t deb \
    -n deckschrubber \
    -v $(echo $DECKSCHRUBBER_TAG | sed 's/[^0-9.]*//g')~ocf1 \
    --deb-generate-changes \
    --deb-dist $DIST_TAG \
    --description "Deckschrubber inspects images of a Docker Registry and removes those older than a given age." \
    --force \
    /tmp/build/bin/deckschrubber=/usr/bin/
