#!/usr/bin/env bash
set -x
# shellcheck source=./scripts/common.bash
source "$(dirname "$0")/common.bash"

if type "$CARGO_HOME/bin/cargo" >/dev/null; then
    echo "Rust is already installed, skipping the procedure"
else
    echo "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | /bin/sh -s -- -y --no-modify-path
fi

"$CARGO_HOME/bin/cargo" install sheldon git-delta
