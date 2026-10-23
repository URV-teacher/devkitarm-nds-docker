#!/usr/bin/env bash
# Tests that the examples are installed, building some of them (it needs devkitARM and libnds). If they are not
# installed (e.g. in the image of the component, which does not include them), installs them into a temporary
# directory with install_examples.sh, which tests it.
set -Eeuo pipefail

: "${DEVKITPRO:?DEVKITPRO is not set: open a new session or run . /etc/profile.d/bmde-devkitpro.sh}"
TEST_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
build_dir="$(mktemp -d)"
examples="${DEVKITPRO}/examples/nds"
if [ ! -d "${examples}" ]; then
  BMDE_ROOT="${build_dir}/root" "${TEST_DIR}/../src/install_examples.sh"
  examples="${build_dir}/root/devkitPro/examples/nds"
fi
cp -r "${examples}/hello_world" "${examples}/time" "${build_dir}"
for example in "${build_dir}"/hello_world/ "${build_dir}"/time/; do
  make -C "${example}"
  find "${example}" -name '*.nds' | grep .
done
rm -rf "${build_dir}"
