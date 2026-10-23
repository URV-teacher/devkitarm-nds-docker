#!/usr/bin/env bash
# Downloads the assets of devkitarm-nds-docker into assets/.
#
# The download logic is the one shared by every component of the BMDE (download_lib.sh, copied from bmde: see it for
# the details). The external resources are listed in the documentation of bmde (docs/development/external-resources.md).
#
#   scripts/download_assets.sh [ASSET...]    (every asset by default)
set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
# shellcheck source=download_lib.sh
source "${SCRIPT_DIR}/download_lib.sh" "$@"

# devkitARM r46, the toolchain of the course. devkitPro no longer distributes old versions: community mirror
asset devkitARM_r46-x86_64-linux.tar.bz2 388b5f5a8f09ccee00073b799ac922aed099b2e0cafcca0d25a5a18b779194ae \
  "https://wii.leseratte10.de/devkitPro/devkitARM/r46%20%282017%29/devkitARM_r46-x86_64-linux.tar.bz2"
# libnds 1.6.2 of devkitPro with dswifi, maxmod, libfat 1.1.0 and libfilesystem, as used by the course. It is not
# published anywhere else in this form, so it is stored in the repository
asset libnds.tar.bz2 95d7edd5553c338eee72e17111d3a139dc556bcf70b22600a7e95ebd47acddfa
# NDS examples of devkitPro at the version of the original BMDE (the tag v20170124 of devkitPro/nds-examples), the
# ones built by test_windows_builds.sh. Installed by install_examples.sh, but not in the image of the component
asset nds-examples.tar.gz 4cf6697670b52d4b931edc0f5f5bd8f6de24c6da29a97944de192d2adbf285dc \
  "https://github.com/devkitPro/nds-examples/archive/54926f9f2d44ab0ea383acd524851837fd3c2998.tar.gz"
# Hello world project of the course, built by test_operation.sh (latest version)
asset hello-world-nds.tar.gz "" "https://github.com/URV-teacher/hello-world-nds/archive/refs/heads/master.tar.gz"

exit "${failed}"
