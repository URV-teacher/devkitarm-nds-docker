set -eo pipefail

if [ ! -d /tmp/hello-world-nds ]; then
  git clone https://github.com/URV-teacher/hello-world-nds.git /tmp/hello-world-nds
fi

(
  cd hello-world-nds
  make
  [ -f hello-world-nds.nds ]
)
rm -rf hello-world-nds
# desmume hello-world-nds.nds  # It can be further validated if we have DeSmuME installed.
