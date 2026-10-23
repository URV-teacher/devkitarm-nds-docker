# devkitARM r46 and libnds, to build NDS projects. The installation is done by the scripts in src/ (with the assets
# downloaded into assets/ by scripts/download_assets.sh), the same ones used to install them in a host (see README.md).
# The devkitPro examples (src/install_examples.sh) are not included: the BMDE full image installs them.
# Base image of the BMDE images (docker-bake.hcl of bmde replaces this stage by the base image being built)
FROM aleixmt/bmde-base:latest AS bmde-base

FROM bmde-base

RUN --mount=type=bind,target=/component \
    /component/src/install_make.sh \
    && /component/src/install_devkitarm.sh \
    && /component/src/install_libnds.sh \
    && rm -rf /var/lib/apt/lists/*

# Directory where the projects to build are mounted
RUN mkdir -p /input
WORKDIR /input

ENTRYPOINT ["bmde-exec", "make"]
CMD []
