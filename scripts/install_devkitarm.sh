#!/usr/bin/env bash
# Installs devkitARM r46 into /URV/bmde/devkitPro/devkitARM, and its environment (DEVKITPRO, DEVKITARM, PATH) into
# /etc/profile.d/bmde-devkitpro.sh. Standalone: can be run in an Ubuntu / Debian host, and is also used by the BMDE
# Docker images. Set BMDE_ROOT to install into another directory.
set -Eeuo pipefail

BMDE_ROOT="${BMDE_ROOT:-/URV/bmde}"
SUDO=""; if [ "$(id -u)" -ne 0 ]; then SUDO=sudo; fi
DEVKITPRO="${BMDE_ROOT}/devkitPro"
DEVKITARM="${DEVKITPRO}/devkitARM"
DEVKITARM_URL="https://wii.leseratte10.de/devkitPro/devkitARM/r46%20%282017%29/devkitARM_r46-x86_64-linux.tar.bz2"
# Pinned, so a changed or tampered download fails instead of being installed
DEVKITARM_SHA256="388b5f5a8f09ccee00073b799ac922aed099b2e0cafcca0d25a5a18b779194ae"

if [ ! -x "${DEVKITARM}/bin/arm-none-eabi-gcc" ]; then
  ${SUDO} apt-get update
  ${SUDO} apt-get install -y --no-install-recommends ca-certificates wget bzip2
  wget "${DEVKITARM_URL}" -O /tmp/devkitARM.tar.bz2
  echo "${DEVKITARM_SHA256}  /tmp/devkitARM.tar.bz2" | sha256sum -c --quiet
  ${SUDO} mkdir -p "${DEVKITPRO}"
  ${SUDO} rm -rf "${DEVKITARM}"
  ${SUDO} tar -xjf /tmp/devkitARM.tar.bz2 -C "${DEVKITPRO}"
  rm -f /tmp/devkitARM.tar.bz2
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
