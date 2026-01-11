#!/bin/bash
set -eo pipefail
rm -f /tmp/libnds.tar.bz2
wget https://raw.githubusercontent.com/URV-teacher/devkitarm-nds-docker/master/data/libnds.tar.bz2 -O /tmp/libnds.tar.bz2
rm -rf "$DEVKITPRO/libnds"
tar -xjf /tmp/libnds.tar.bz2 -C "$DEVKITPRO"
rm /tmp/libnds.tar.bz2
