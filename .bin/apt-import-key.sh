#!/bin/sh

for i in $*; do
    gpg --keyserver subkeys.pgp.net --recv-keys $i
    gpg --armor --export $i | apt-key add -
    echo "$i key imported"
done
