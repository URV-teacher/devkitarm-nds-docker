#!/usr/bin/env bash
# Tests the build operation: builds the hello world project of the course.
set -Eeuo pipefail

work_dir="$(mktemp -d)"
git clone https://github.com/URV-teacher/hello-world-nds.git "${work_dir}/hello-world-nds"
make -C "${work_dir}/hello-world-nds"
ls "${work_dir}"/hello-world-nds/*.nds
rm -rf "${work_dir}"
