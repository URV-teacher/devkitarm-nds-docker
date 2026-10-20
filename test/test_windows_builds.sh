#!/usr/bin/env bash
# Tests that the devkitARM, libnds and examples of the BMDE build the same binaries as the Windows BMDE: builds the
# examples of devkitPro listed in windows_builds.sha1 and compares their binaries with the SHA-1 of the binaries built
# by the Windows BMDE (needs devkitARM, libnds and the examples). Fails if a binary differs, unless it is a known
# difference (windows_builds_known_differences.txt).
set -Eeuo pipefail

: "${DEVKITPRO:?DEVKITPRO is not set: open a new session or run . /etc/profile.d/bmde-devkitpro.sh}"
TEST_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
CHECKSUMS="${TEST_DIR}/windows_builds.sha1"
KNOWN_DIFFERENCES="${TEST_DIR}/windows_builds_known_differences.txt"

work_dir="$(mktemp -d)"
cp -r "${DEVKITPRO}/examples/nds/." "${work_dir}"
# Project of each binary (libraries are built into the lib/ folder of their project)
cut -d ' ' -f 3 "${CHECKSUMS}" | xargs -n 1 dirname | sed 's|/lib$||' | sort -u | while read -r project; do
  # make clean first: some examples have binaries already built
  make -s -C "${work_dir}/${project}" clean > /dev/null
  make -s -C "${work_dir}/${project}" > /dev/null 2>&1 || echo "${project}: build failed"
done
differ="$(cd "${work_dir}" && sha1sum -c --quiet "${CHECKSUMS}" 2> /dev/null | sed -n 's/: FAILED.*$//p')" || true
rm -rf "${work_dir}"
known="$(grep -v '^#' "${KNOWN_DIFFERENCES}")"

status=0
total="$(wc -l < "${CHECKSUMS}")"
echo "$(( total - $(printf '%s' "${differ}" | grep -c .) )) of ${total} binaries are the same as the ones of the Windows BMDE"
while read -r binary; do
  if [ -z "${binary}" ]; then
    continue
  elif grep -qxF "${binary}" <<< "${known}"; then
    echo "Known difference: ${binary}"
  else
    echo "UNEXPECTED DIFFERENCE: ${binary}"
    status=1
  fi
done <<< "${differ}"
while read -r binary; do
  if ! grep -qxF "${binary}" <<< "${differ}"; then
    echo "Known difference that is now the same (remove it from $(basename "${KNOWN_DIFFERENCES}")): ${binary}"
  fi
done <<< "${known}"
exit "${status}"
