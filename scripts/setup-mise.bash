#!/usr/bin/env bash
# Install the tools pinned in config/mise/config.toml (Node, uv, Deno, Terraform).
# shellcheck source=./scripts/common.bash
source "$(dirname "$0")/common.bash"

# macOS gets mise from the Brewfile. Elsewhere use the official installer (~/.local/bin).
if ! command -v mise >/dev/null; then
    echo "Installing mise..."
    curl -fsSL https://mise.run | sh
fi

# setup-links.bash links config/mise to ~/.config/mise, which mise reads as the global config.
mise install --yes

# Deno completions (zeno.zsh runs on Deno)
mkdir -p "$XDG_DATA_HOME/zsh/completions"
mise exec -- deno completions zsh >"$XDG_DATA_HOME/zsh/completions/_deno"
