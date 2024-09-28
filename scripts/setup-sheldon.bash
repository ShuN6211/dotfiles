#!/usr/bin/env bash
set -x
# shellcheck source=./scripts/common.bash
source "$(dirname "$0")/common.bash"

if [ ! -e "$CARGO_HOME/env" ]; then
    echo "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | /bin/sh -s -- -y --no-modify-path
else
    echo "Rust is already installed, skipping the procedure"
fi

. "$CARGO_HOME/env"
cargo install sheldon
