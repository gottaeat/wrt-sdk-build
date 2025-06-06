FROM debian:12.11 AS wrt-sdk-build

ARG WRT_VER=24.10.0
ENV WRT_VER=${WRT_VER}
ENV FORCE_UNSAFE_CONFIGURE=1

WORKDIR /build

RUN \
    apt update && \
    apt install -y \
        bison build-essential clang curl file flex g++ gawk gettext git \
        libncurses-dev libssl-dev python3-dev python3-distutils \
        python3-setuptools rsync swig unzip wget zlib1g-dev && \
    git clone --depth=1 --recursive --shallow-submodules \
        git://git.openwrt.org/openwrt/openwrt.git -b v${WRT_VER} && \
    cd openwrt/ && \
    ./scripts/feeds update -a && \
    ./scripts/feeds install -a && \
    mkdir /out

WORKDIR /build/openwrt
