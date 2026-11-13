#!/usr/bin/env bash
# Shared setup for every scripts/setup-*.bash. Stop at the first failure.
set -euxo pipefail

export CUR_DIR REPO_DIR
CUR_DIR="$(
    cd "$(dirname "$0")" || exit 1
    pwd
)"
REPO_DIR="$(
    cd "$(dirname "$0")/.." || exit 1
    pwd
)"

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"

# Each setup script runs in its own process, so make Homebrew and
# ~/.local/bin (mise on Linux) visible even on a fresh machine.
if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
export PATH="$HOME/.local/bin:$PATH"
