# XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache

# ZDOTDIR
export ZDOTDIR=$XDG_CONFIG_HOME/zsh

### Deno ###
export DENO_INSTALL="$XDG_DATA_HOME/deno"
export DENO_INSTALL_ROOT="$DENO_INSTALL"

### nvm ###
export NVM_DIR="$XDG_DATA_HOME/nvm"

# Rust
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"

### sheldon ###
export SHELDON_CONFIG_DIR="$ZDOTDIR"
