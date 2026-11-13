#!/usr/bin/env bash
# shellcheck source=./scripts/common.bash
source "$(dirname "$0")/common.bash"

[ "$(uname)" = "Darwin" ] || exit 0
[ -z "${SKIP_HOMEBREW:-}" ] || exit 0

if command -v brew >/dev/null; then
    echo "Homebrew is already installed."
else
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "Updating Homebrew..."
brew update

echo "Installing Homebrew apps..."
brew bundle install --file "${REPO_DIR}/config/homebrew/Brewfile" --verbose
