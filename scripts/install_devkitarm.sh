#!/bin/bash
set -eo pipefail

export DEVKITPRO="$HOME/bmde/devkitPro"
export DEVKITARM=$DEVKITPRO/devkitARM
DEST="$HOME/.bashrc"

# Install environment variables if not already set
if ! grep -q "export DEVKITPRO=" "$DEST"; then
    echo "export DEVKITPRO=$DEVKITPRO" >> "$DEST"
fi
if ! grep -q "export DEVKITARM=" "$DEST"; then
    echo "export DEVKITARM=$DEVKITARM" >> "$DEST"
fi
if ! grep -q "export DESMUME=" "$DEST"; then
    echo "export DESMUME=/" >> "$DEST"
fi
if ! grep -q "export PATH=.*\$DEVKITARM/bin" "$DEST"; then
    echo "export PATH=\"\$DEVKITARM/bin:\$PATH\"" >> "$DEST"
fi

mkdir -p "$DEVKITPRO" "$DEVKITARM"

# Download and install devkitARM only if not already installed
rm -f /tmp/devkitARM.tar.bz2
wget --no-check-certificate "https://wii.leseratte10.de/devkitPro/devkitARM/r46%20%282017%29/devkitARM_r46-x86_64-linux.tar.bz2" -O /tmp/devkitARM.tar.bz2 \
rm -rf "$DEVKITARM"
tar -xf /tmp/devkitARM.tar.bz2 -C "$DEVKITPRO" \
rm /tmp/devkitARM.tar.bz2


# Copy examples if they exist in current directory and destination doesn't have them
rm -f /tmp/examples.tar.bz2
wget https://raw.githubusercontent.com/URV-teacher/devkitarm-nds-docker/master/data/examples.tar.bz2 -O /tmp/examples.tar.bz2
rm -rf "$DEVKITPRO/examples"
tar -xjf /tmp/examples.tar.bz2 -C "$DEVKITPRO"
rm /tmp/examples.tar.bz2

