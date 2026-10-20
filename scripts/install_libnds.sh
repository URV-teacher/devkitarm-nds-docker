#!/usr/bin/env bash
# Installs the libnds of the course into /URV/bmde/devkitPro/libnds. Needs devkitARM (install_devkitarm.sh).
# Standalone: can be run in an Ubuntu / Debian host, and is also used by the BMDE Docker images.
set -Eeuo pipefail

BMDE_ROOT="${BMDE_ROOT:-/URV/bmde}"
SUDO=""; if [ "$(id -u)" -ne 0 ]; then SUDO=sudo; fi
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
REPO_URL="https://raw.githubusercontent.com/URV-teacher/devkitarm-nds-docker/master"

if [ ! -d "${BMDE_ROOT}/devkitPro/libnds/lib" ]; then
  # Use the file of the repository if the script is run from it, or download it otherwise
  if [ -f "${SCRIPT_DIR}/../data/libnds.tar.bz2" ]; then
    cp "${SCRIPT_DIR}/../data/libnds.tar.bz2" /tmp/libnds.tar.bz2
  else
    wget "${REPO_URL}/data/libnds.tar.bz2" -O /tmp/libnds.tar.bz2
  fi
  ${SUDO} mkdir -p "${BMDE_ROOT}/devkitPro"
  ${SUDO} rm -rf "${BMDE_ROOT}/devkitPro/libnds"
  ${SUDO} tar -xjf /tmp/libnds.tar.bz2 -C "${BMDE_ROOT}/devkitPro"
  rm -f /tmp/libnds.tar.bz2
fi

echo "libnds installed in ${BMDE_ROOT}/devkitPro/libnds"
