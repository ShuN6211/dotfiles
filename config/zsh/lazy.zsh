# recommended scripts for homebrew
case "$OSTYPE" in
darwin*)
    export HOMEBREW_PREFIX="/opt/homebrew"
    export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
    export HOMEBREW_REPOSITORY="/opt/homebrew"
    export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:"
    export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"
    ;;
esac

### replace BSD to GNU ###
case "$OSTYPE" in
    darwin*)
        (( ${+commands[gdate]} )) && alias date='gdate'
        (( ${+commands[gcp]} )) && alias cp='gcp'
        (( ${+commands[gmv]} )) && alias mv='gmv'
        (( ${+commands[grm]} )) && alias rm='grm'
        (( ${+commands[gdu]} )) && alias du='gdu'
        (( ${+commands[ghead]} )) && alias head='ghead'
        (( ${+commands[gtail]} )) && alias tail='gtail'
        (( ${+commands[gsed]} )) && alias sed='gsed'
        (( ${+commands[ggrep]} )) && alias grep='ggrep'
        (( ${+commands[gfind]} )) && alias find='gfind'
        (( ${+commands[gdirname]} )) && alias dirname='gdirname'
        (( ${+commands[gxargs]} )) && alias xargs='gxargs'
    ;;
esac

# alias - modern tools and GNU preferred
if (( ${+commands[eza]} )); then
    alias ls='eza --color=always --icons=always'
    alias la='eza --color=always --icons=always -a'
    alias ll='eza --color=always --icons=always -l'
    alias lla='eza --color=always --icons=always -la'
    alias tree='eza --color=always --icons=always --tree'
elif (( ${+commands[gls]} )); then
    alias ls='gls --color=auto -F'
    alias la='gls --color=auto -aF'
    alias ll='gls --color=auto -lF'
    alias lla='gls --color=auto -laF'
else
    alias ls='ls -F'
    alias la='ls -aF'
    alias ll='ls -lF'
    alias lla='ls -laF'
fi

# mkdir with -p option (GNU preferred)
if (( ${+commands[gmkdir]} )); then
    alias mkdir='gmkdir -p'
else
    alias mkdir='mkdir -p'
fi

### completion styles ###
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# fzf
export FZF_DEFAULT_OPTS='--reverse --border --ansi --bind="ctrl-d:print-query,ctrl-p:replace-query"'
export FZF_DEFAULT_COMMAND='fd --hidden --color=always'

### key-bindings
bindkey "^A" beginning-of-line # C-a
bindkey "^E" end-of-line       # C-e
bindkey "^K" kill-line         # C-k

### one password ###
[[ -f "$XDG_CONFIG_HOME/op/plugins.sh" ]] && source "$XDG_CONFIG_HOME/op/plugins.sh"

### gcloud sdk ###
# Try multiple possible completion paths
for gcloud_completion in \
    "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc" \
    "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc" \
    "$(brew --prefix)/Caskroom/gcloud-cli/latest/google-cloud-sdk/completion.zsh.inc"
do
    [[ -f "$gcloud_completion" ]] && source "$gcloud_completion" && break
done

autoload -Uz compinit
compinit -d "$XDG_STATE_HOME/zcompdump"
