#!/usr/bin/env bash
# Tests that devkitARM is installed and its environment loaded.
set -Eeuo pipefail

: "${DEVKITPRO:?DEVKITPRO is not set: open a new session or run . /etc/profile.d/bmde-devkitpro.sh}"
: "${DEVKITARM:?DEVKITARM is not set: open a new session or run . /etc/profile.d/bmde-devkitpro.sh}"
arm-none-eabi-gcc --version
arm-none-eabi-as --version
arm-none-eabi-ld --version
ndstool | head -n 1
echo "devkitARM OK"
