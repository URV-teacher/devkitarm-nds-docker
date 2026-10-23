#!/usr/bin/env bash
# Installs the devkitPro NDS project examples into /URV/bmde/devkitPro/examples/nds (optional). Can be run in an
# Ubuntu / Debian host from a checkout of the repository (after scripts/download_assets.sh), and is used by the BMDE
# full image and by the tests of the examples; the image of the component does not include them. Set BMDE_ROOT to
# install into another directory.
set -Eeuo pipefail

BMDE_ROOT="${BMDE_ROOT:-/URV/bmde}"
SUDO=""; if [ "$(id -u)" -ne 0 ]; then SUDO=sudo; fi
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
EXAMPLES_DIR="${BMDE_ROOT}/devkitPro/examples/nds"
EXAMPLES_TARBALL="${SCRIPT_DIR}/../assets/nds-examples.tar.gz"

if [ ! -d "${EXAMPLES_DIR}" ]; then
  if [ ! -f "${EXAMPLES_TARBALL}" ]; then
    echo "${EXAMPLES_TARBALL} not found: download it with scripts/download_assets.sh" >&2
    exit 1
  fi
  ${SUDO} mkdir -p "${EXAMPLES_DIR}"
  ${SUDO} tar -xzf "${EXAMPLES_TARBALL}" -C "${EXAMPLES_DIR}" --strip-components=1
fi

echo "Examples installed in ${EXAMPLES_DIR}"
