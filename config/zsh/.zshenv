# XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache

# ZDOTDIR
export ZDOTDIR=$XDG_CONFIG_HOME/zsh

# Rust
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"

### sheldon ###
export SHELDON_CONFIG_DIR="$ZDOTDIR"
