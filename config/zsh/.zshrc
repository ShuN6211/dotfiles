# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### paths ###
typeset -gU PATH path
typeset -gU FPATH fpath

path=(
    '/usr/local/bin'(N-/)
    '/opt/homebrew/bin'(N-/)
    '/usr/bin'(N-/)
    '/bin'(N-/)
    '/usr/local/sbin'(N-/)
    '/opt/homebrew/sbin'(N-/)
    '/usr/sbin'(N-/)
    '/sbin'(N-/)
)

path=(
    "$HOME/.local/bin"(N-/)
    "$CARGO_HOME/bin"(N-/)
    "$DENO_INSTALL/bin"(N-/)
    "$path[@]"
)

fpath=(
    "$XDG_DATA_HOME/zsh/completions"(N-/)
    "$fpath[@]"
)

## history ###
export HISTFILE="$XDG_STATE_HOME/zsh_history"
export HISTSIZE=12000
export SAVEHIST=10000

### source ###
source() {
    local input="$1"
    local cache="$input.zwc"
    if [[ ! -f "$cache" || "$input" -nt "$cache" ]]; then
        zcompile "$input"
    fi
    \builtin source "$@"
}

### hooks ###
zshaddhistory() {
    local line="${1%%$'\n'}"
    [[ ! "$line" =~ "^(cd|history|jj?|lazygit|la|ll|ls|rm|rmdir|trash)($| )" ]]
}

# sheldon cache technique
# See also https://zenn.dev/fuzmare/articles/zsh-plugin-manager-cache
cache_dir=${XDG_CACHE_HOME:-$HOME/.cache}
sheldon_cache="$cache_dir/sheldon.zsh"
sheldon_toml="$SHELDON_CONFIG_DIR/plugins.toml"
if [[ ! -r "$sheldon_cache" || "$sheldon_toml" -nt "$sheldon_cache" ]]; then
  sheldon source > $sheldon_cache
fi
source "$sheldon_cache"
unset cache_dir sheldon_cache sheldon_toml

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh