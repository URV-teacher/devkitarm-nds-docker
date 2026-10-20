#!/usr/bin/env bash
# Tests that the examples are installed, building some of them (it needs devkitARM and libnds).
set -Eeuo pipefail

: "${DEVKITPRO:?DEVKITPRO is not set: open a new session or run . /etc/profile.d/bmde-devkitpro.sh}"
build_dir="$(mktemp -d)"
cp -r "${DEVKITPRO}/examples/nds/hello_world" "${DEVKITPRO}/examples/nds/time" "${build_dir}"
for example in "${build_dir}"/*/; do
  make -C "${example}"
  find "${example}" -name '*.nds' | grep .
done
rm -rf "${build_dir}"
