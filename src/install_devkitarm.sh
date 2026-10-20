#!/usr/bin/env bash
# Installs devkitARM r46 into /URV/bmde/devkitPro/devkitARM, and its environment (DEVKITPRO, DEVKITARM, PATH) into
# /etc/profile.d/bmde-devkitpro.sh. Can be run in an Ubuntu / Debian host from a checkout of the repository (after
# scripts/download_assets.sh), and is also used by the BMDE Docker images. Set BMDE_ROOT to install into another
# directory.
set -Eeuo pipefail

BMDE_ROOT="${BMDE_ROOT:-/URV/bmde}"
SUDO=""; if [ "$(id -u)" -ne 0 ]; then SUDO=sudo; fi
DEVKITPRO="${BMDE_ROOT}/devkitPro"
DEVKITARM="${DEVKITPRO}/devkitARM"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
DEVKITARM_TARBALL="${SCRIPT_DIR}/../assets/devkitARM_r46-x86_64-linux.tar.bz2"

if [ ! -x "${DEVKITARM}/bin/arm-none-eabi-gcc" ]; then
  if [ ! -f "${DEVKITARM_TARBALL}" ]; then
    echo "${DEVKITARM_TARBALL} not found: download it with scripts/download_assets.sh" >&2
    exit 1
  fi
  ${SUDO} apt-get update
  ${SUDO} apt-get install -y --no-install-recommends bzip2
  ${SUDO} mkdir -p "${DEVKITPRO}"
  ${SUDO} rm -rf "${DEVKITARM}"
  ${SUDO} tar -xjf "${DEVKITARM_TARBALL}" -C "${DEVKITPRO}"
fi

# DESMUME is needed by the Makefiles of the course even to build; the DeSmuME install sets its real value
${SUDO} tee /etc/profile.d/bmde-devkitpro.sh > /dev/null <<PROFILE
export DEVKITPRO="${DEVKITPRO}"
export DEVKITARM="${DEVKITARM}"
if [ -z "\${DESMUME:-}" ]; then export DESMUME=/; fi
case ":\${PATH}:" in
  *":${DEVKITARM}/bin:"*) ;;
  *) export PATH="${DEVKITARM}/bin:\${PATH}" ;;
esac
PROFILE

echo "devkitARM installed in ${DEVKITARM}. Open a new session or run: . /etc/profile.d/bmde-devkitpro.sh"
