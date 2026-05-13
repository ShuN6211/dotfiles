#!/usr/bin/env bash
set -x
# shellcheck source=./scripts/common.bash
source "$(dirname "$0")/common.bash"

# On macOS, sheldon is installed via Homebrew (Brewfile)
[ "$(uname)" = "Darwin" ] && exit

echo "Installing sheldon..."
curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
    | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin
