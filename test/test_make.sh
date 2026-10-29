#!/usr/bin/env bash
# Tests that make is installed.
set -Eeuo pipefail

make --version
echo "make OK"
