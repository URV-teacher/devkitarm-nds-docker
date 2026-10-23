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
# libnds 1.6.2 of devkitPro with dswifi, maxmod, libfat 1.1.0 and libfilesystem, and the NDS examples of devkitPro, as
# used by the course. They are not published anywhere else in this form, so they are stored in the repository
asset libnds.tar.bz2 95d7edd5553c338eee72e17111d3a139dc556bcf70b22600a7e95ebd47acddfa
asset examples.tar.bz2 46e278fe51c8b0d1d0a67d7e1dd6b4db3d498f5b4d9eccbb5a678b6a85b25898
# Hello world project of the course, built by test_operation.sh (latest version)
asset hello-world-nds.tar.gz "" "https://github.com/URV-teacher/hello-world-nds/archive/refs/heads/master.tar.gz"

exit "${failed}"
