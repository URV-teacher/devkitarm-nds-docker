set -eo pipefail

wget https://raw.githubusercontent.com/URV-teacher/devkitarm-nds-docker/master/data/libnds.tar.bz2 -O /tmp/libnds.tar.bz2
tar -xjf /tmp/libnds.tar.bz2 -C $DEVKITPRO
rm /tmp/libnds.tar.bz2
