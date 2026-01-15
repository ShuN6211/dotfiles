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
    zsh \
    fontconfig

# Install Fira Code Nerd Font
echo "Installing Fira Code Nerd Font..."
FONT_DIR="/usr/local/share/fonts/fira-code-nerd"
mkdir -p "$FONT_DIR"
wget -q --show-progress -O /tmp/FiraCode.zip \
    "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip"
unzip -q /tmp/FiraCode.zip -d "$FONT_DIR"
rm /tmp/FiraCode.zip
echo "Fira Code Nerd Font installed successfully"
fc-cache -fv

# Install starship (not available in apt repository, using official installer)
echo "Installing Starship..."
curl -sS https://starship.rs/install.sh | sh -s -- --yes
echo "Starship installed successfully"
