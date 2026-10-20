#!/usr/bin/env bash
# Installs the devkitPro NDS project examples into /URV/bmde/devkitPro/examples (optional).
# Standalone: can be run in an Ubuntu / Debian host, and is also used by the BMDE Docker images.
set -Eeuo pipefail

BMDE_ROOT="${BMDE_ROOT:-/URV/bmde}"
SUDO=""; if [ "$(id -u)" -ne 0 ]; then SUDO=sudo; fi
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
REPO_URL="https://raw.githubusercontent.com/URV-teacher/devkitarm-nds-docker/master"

if [ ! -d "${BMDE_ROOT}/devkitPro/examples" ]; then
  # Use the file of the repository if the script is run from it, or download it otherwise
  if [ -f "${SCRIPT_DIR}/../data/examples.tar.bz2" ]; then
    cp "${SCRIPT_DIR}/../data/examples.tar.bz2" /tmp/examples.tar.bz2
  else
    wget "${REPO_URL}/data/examples.tar.bz2" -O /tmp/examples.tar.bz2
  fi
  ${SUDO} mkdir -p "${BMDE_ROOT}/devkitPro"
  ${SUDO} tar -xjf /tmp/examples.tar.bz2 -C "${BMDE_ROOT}/devkitPro"
  rm -f /tmp/examples.tar.bz2
fi

echo "Examples installed in ${BMDE_ROOT}/devkitPro/examples"
