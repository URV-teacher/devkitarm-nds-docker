#!/usr/bin/env bash
# Installs the devkitPro NDS project examples into /URV/bmde/devkitPro/examples (optional).
# Can be run in an Ubuntu / Debian host from a checkout of the repository, and is also used by the BMDE Docker images.
set -Eeuo pipefail

BMDE_ROOT="${BMDE_ROOT:-/URV/bmde}"
SUDO=""; if [ "$(id -u)" -ne 0 ]; then SUDO=sudo; fi
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"

if [ ! -d "${BMDE_ROOT}/devkitPro/examples" ]; then
  ${SUDO} mkdir -p "${BMDE_ROOT}/devkitPro"
  ${SUDO} tar -xjf "${SCRIPT_DIR}/../assets/examples.tar.bz2" -C "${BMDE_ROOT}/devkitPro"
fi

echo "Examples installed in ${BMDE_ROOT}/devkitPro/examples"
