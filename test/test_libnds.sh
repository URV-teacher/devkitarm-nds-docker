#!/usr/bin/env bash
# Tests that libnds is installed, building one of the project templates of the course with it.
set -Eeuo pipefail

: "${DEVKITPRO:?DEVKITPRO is not set: open a new session or run . /etc/profile.d/bmde-devkitpro.sh}"
[ -f "${DEVKITPRO}/libnds/lib/libnds9.a" ]
cat > /tmp/test_libnds.c <<'C'
#include <nds.h>
int main(void) { consoleDemoInit(); while (1) swiWaitForVBlank(); }
C
arm-none-eabi-gcc -march=armv5te -mtune=arm946e-s -DARM9 -specs=ds_arm9.specs -I"${DEVKITPRO}/libnds/include" \
  /tmp/test_libnds.c -L"${DEVKITPRO}/libnds/lib" -lnds9 -o /tmp/test_libnds.elf
rm -f /tmp/test_libnds.c /tmp/test_libnds.elf
echo "libnds OK"
