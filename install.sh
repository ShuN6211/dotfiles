#!/bin/sh
set -e

REPO="github.com/ShuN6211/dotfiles"

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

run_ghq() {
    if command -v ghq >/dev/null 2>&1; then
        ghq "$@"
    else
        nix shell nixpkgs#ghq -c ghq "$@"
    fi
}

GHQ_ROOT="$(run_ghq root)"
INSTALL_DIR="$GHQ_ROOT/$REPO"

echo "Fetching dotfiles with ghq..."
run_ghq get -u "$REPO"

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
