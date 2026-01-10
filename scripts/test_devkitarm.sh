set -eo pipefail

make --help && \
arm-none-eabi-gcc --help && \
arm-none-eabi-as --help && \
arm-none-eabi-ld --help && \
ndstool -?
