#!/bin/bash
set -euxo pipefail

git clone https://github.com/fraunhoferfokus/deckschrubber.git /tmp/deckschrubber
cd /tmp/deckschrubber
git checkout $DECKSCHRUBBER_TAG

# go needs a place to put the built binaries.
mkdir -p /tmp/build/bin
mkdir /tmp/go
export GOPATH=/tmp/go
export GOHOME=/tmp/build
export GOBIN=/tmp/build/bin

go get -v

# Build the .deb and put it in /mnt, which is mounted from build/ in the Makefile.
fpm -s dir -t deb \
    -n deckschrubber \
    -v $(echo $DECKSCHRUBBER_TAG | sed 's/[^0-9.]*//g')~ocf1 \
    -p /mnt \
    /tmp/build/bin/deckschrubber=/usr/bin/
