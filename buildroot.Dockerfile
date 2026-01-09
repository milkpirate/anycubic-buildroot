FROM ubuntu:24.04 AS builder

LABEL \
  org.opencontainers.image.title="Buildroot dependencies" \
  org.opencontainers.image.version="0.0.1" \
  org.opencontainers.image.ref.name="buildroot-deps" \
  org.opencontainers.image.annotation.documentation.url="https://github.com/opencontainers/image-spec/blob/master/annotations.md"

RUN mkdir -p /repo

RUN apt-get update \
  && apt-get install --yes \
    bc \
    build-essential \
    bzip2 \
    cpio \
    curl \
    extlinux \
    file \
    git \
    git-lfs \
    libelf-dev \
    libncurses5-dev \
    libssl-dev \
    nano \
    rsync \
    unzip \
    wget

WORKDIR /repo
