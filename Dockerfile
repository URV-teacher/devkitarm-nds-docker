# devkitARM r46, libnds and the devkitPro examples, to build NDS projects. The installation is done by the scripts in
# scripts/, the same ones used to install them in a host (see README.md).
# Base image of the BMDE images (docker-bake.hcl of bmde replaces this stage by the base image being built)
FROM aleixmt/bmde-base:latest AS bmde-base

FROM bmde-base

RUN --mount=type=bind,target=/component \
    /component/scripts/install_make.sh \
    && /component/scripts/install_devkitarm.sh \
    && /component/scripts/install_libnds.sh \
    && /component/scripts/install_examples.sh \
    && rm -rf /var/lib/apt/lists/*

# Directory where the projects to build are mounted
RUN mkdir -p /input
WORKDIR /input

ENTRYPOINT ["bmde-exec", "make"]
CMD []
