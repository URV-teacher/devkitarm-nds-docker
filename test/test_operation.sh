#!/usr/bin/env bash
# Tests the build operation: builds the hello world project of the course.
set -Eeuo pipefail

work_dir="$(mktemp -d)"
# Hello world project of the course, downloaded by scripts/download_assets.sh
mkdir "${work_dir}/hello-world-nds"
tar -xzf "$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)/../assets/hello-world-nds.tar.gz" \
  -C "${work_dir}/hello-world-nds" --strip-components=1
make -C "${work_dir}/hello-world-nds"
ls "${work_dir}"/hello-world-nds/*.nds
rm -rf "${work_dir}"
echo "build operation OK"
