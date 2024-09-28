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

# fzf
export FZF_DEFAULT_OPTS='--reverse'

# alias
alias ls="ls -F"
alias la="ls -a"
alias ll="ls -l"
alias lla="ls -la"
alias mkdir="mkdir -p"
alias python="python3"

# zsh_sessionsを作らない
# export SHELL_SESSIONS_DISABLE=1
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt GLOBDOTS
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt INTERACTIVE_COMMENTS
setopt NO_SHARE_HISTORY # 少し微妙
setopt MAGIC_EQUAL_SUBST
setopt PRINT_EIGHT_BIT
setopt NO_FLOW_CONTROL
# 補完で大文字にもマッチ
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 塗りつぶし
zstyle ':completion:*' menu select
## 補完候補を一覧表示したとき、Tabや矢印で選択できるようにする
zstyle ':completion:*:default' menu select=1
# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..
setopt correct
setopt no_beep
setopt AUTO_PARAM_KEYS

### key-bindings
bindkey "^A" beginning-of-line # C-a
bindkey "^E" end-of-line       # C-e
bindkey "^K" kill-line         # C-k
