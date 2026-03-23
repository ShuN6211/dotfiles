#!/bin/sh
set -e

INSTALL_DIR="${INSTALL_DIR:-$HOME/workspace/dotfiles}"

# Install Nix (Determinate Systems installer)
if ! command -v nix >/dev/null 2>&1; then
    echo "Installing Nix..."
    curl --proto '=https' --tlsv1.2 -sSf -L \
        https://install.determinate.systems/nix | sh -s -- install
    # Source nix environment
    if [ -f "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]; then
        . "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
    fi
fi

# Install Homebrew on macOS (needed for casks)
case "$(uname)" in
    Darwin)
        if ! command -v brew >/dev/null 2>&1; then
            echo "Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        ;;
esac

# Clone dotfiles
if [ -d "$INSTALL_DIR" ]; then
    echo "Updating dotfiles..."
    git -C "$INSTALL_DIR" pull
else
    echo "Installing dotfiles..."
    git clone https://github.com/ShuN6211/dotfiles.git "$INSTALL_DIR"
fi

cd "$INSTALL_DIR"

# Build and activate
case "$(uname)" in
    Darwin)
        echo "Activating nix-darwin configuration..."
        nix run nix-darwin -- switch --flake .#shun-macbook
        ;;
    Linux)
        echo "Activating home-manager configuration..."
        nix run home-manager -- switch --flake .#shun-linux
        ;;
    *)
        echo "Unsupported platform: $(uname)"
        exit 1
        ;;
esac

echo "Done! Please restart your shell."
