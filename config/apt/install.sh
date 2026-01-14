#!/bin/sh -e

apt-get update
apt-get upgrade -y
apt-get install -y \
    autoconf \
    build-essential \
    vim \
    clang \
    clangd \
    clang-format \
    cmake \
    git \
    tig \
    gpg \
    python3 \
    python3-pip \
    jq \
    shellcheck \
    tmux \
    fzf \
    fd-find \
    trash-cli \
    unzip \
    wget \
    zip \
    zsh
