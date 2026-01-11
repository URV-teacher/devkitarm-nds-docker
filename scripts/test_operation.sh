#!/bin/bash
set -eo pipefail

rm -rf /tmp/hello-world-nds
git clone https://github.com/URV-teacher/hello-world-nds.git /tmp/hello-world-nds

(
  cd hello-world-nds
  make
  [ -f hello-world-nds.nds ]
)
rm -rf hello-world-nds
# desmume hello-world-nds.nds  # It can be further validated if we have DeSmuME installed.
