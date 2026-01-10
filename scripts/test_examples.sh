set -eo pipefail

cd $DEVKITPRO/examples
for i in *; do
  if [ -d "$i" ]; then
      comp_msg=$(cd "$i" && make clean && make 2>&1)
      echo "$comp_msg"
  fi
done
