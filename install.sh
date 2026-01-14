#!/bin/sh
INSTALL_DIR="${INSTALL_DIR:-$HOME/workspace/dotfiles}"

# Install necessary tools
if command -v apt-get >/dev/null 2>&1; then
    # Ubuntu/Debian
    sudo apt-get update
    sudo apt-get install -y curl git
elif command -v yum >/dev/null 2>&1; then
    # RHEL/CentOS
    sudo yum install -y curl git
elif command -v dnf >/dev/null 2>&1; then
    # Fedora
    sudo dnf install -y curl git
elif command -v pacman >/dev/null 2>&1; then
    # Arch
    sudo pacman -S --noconfirm curl git
elif command -v apk >/dev/null 2>&1; then
    # Alpine
    sudo apk add curl git
elif command -v brew >/dev/null 2>&1; then
    # macOS
    brew install curl git
else
    echo "Unsupported package manager. Please install curl and git manually."
    exit 1
fi

if [ -d "$INSTALL_DIR" ]; then
    echo "Updating dotfiles..."
    git -C "$INSTALL_DIR" pull
else
    echo "Installing dotfiles..."
    git clone https://github.com/ShuN6211/dotfiles.git "$INSTALL_DIR"
fi

/bin/bash "$INSTALL_DIR/scripts/setup.bash"
