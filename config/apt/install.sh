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
