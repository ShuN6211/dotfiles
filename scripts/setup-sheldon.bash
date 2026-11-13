#!/usr/bin/env bash
# shellcheck source=./scripts/common.bash
source "$(dirname "$0")/common.bash"

# On macOS, sheldon is installed via Homebrew (Brewfile)
[ "$(uname)" != "Darwin" ] || exit 0
command -v sheldon >/dev/null && exit 0

echo "Installing sheldon..."
curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
    | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin
