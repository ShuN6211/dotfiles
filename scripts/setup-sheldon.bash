#!/usr/bin/env bash
set -x
# shellcheck source=./scripts/common.bash
source "$(dirname "$0")/common.bash"

if [ -d "$XDG_DATA_HOME/sheldon/bin" ]; then
    echo "sheldon is already installed."
else
    echo "Installing sheldon..."
    curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
    | bash -s -- --repo rossmacarthur/sheldon --to "$XDG_DATA_HOME/bin"
    ln -s "$XDG_DATA_HOME/sheldon/bin/sheldon" "$HOME/.local/bin/sheldon"
fi
