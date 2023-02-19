# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### zinit ###
typeset -gAH ZINIT
ZINIT[HOME_DIR]="$XDG_DATA_HOME/zinit"
ZINIT[ZCOMPDUMP_PATH]="$XDG_STATE_HOME/zcompdump"
source "${ZINIT[HOME_DIR]}/zinit.git/zinit.zsh"

# powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# history
export HISTFILE=$XDG_STATE_HOME/zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
# 他のzshと履歴を共有
setopt inc_append_history
setopt share_history

## コマンド補完
zinit ice wait'0'; zinit light zsh-users/zsh-completions
FPATH=$(brew --prefix)/completions/zsh:$FPATH # brew
autoload -Uz compinit && compinit


## zeno設定
zinit ice lucid depth"1" blockf
zinit light yuki-yano/zeno.zsh

if [[ -n $ZENO_LOADED ]]; then
  # ここに任意のZLEの記述を行う
  bindkey ' '  zeno-auto-snippet
  bindkey '^m' zeno-auto-snippet-and-accept-line
  bindkey '^p' zeno-completion
  bindkey '^g' zeno-ghq-cd
  bindkey '^r' zeno-history-selection
  bindkey '^x' zeno-insert-snippet
fi

## 履歴補完
zinit light zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"
ZSH_AUTOSUGGEST_CLEAR_WIDGETS=(zeno-auto-snippet-and-accept-line $ZSH_AUTOSUGGEST_CLEAR_WIDGETS)

## シンタックスハイライト
zinit light zdharma-continuum/fast-syntax-highlighting

# 補完で大文字にもマッチ
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 塗りつぶし
zstyle ':completion:*' menu select

## 補完候補を一覧表示したとき、Tabや矢印で選択できるようにする
zstyle ':completion:*:default' menu select=1 

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# コマンドミスを修正
setopt correct

# '#' 以降をコメントとして扱う
setopt interactive_comments

# cdなし
setopt auto_cd

# cd - で以前に移動したディレクトリを表示
setopt auto_pushd

# no-heep
setopt no_beep

## 環境変数を補完
setopt AUTO_PARAM_KEYS

# alias
alias ls="ls -F"
alias la="ls -a"
alias ll="ls -l"
alias lla="ls -la"

alias mkdir="mkdir -p"

alias py="python3"
alias em="emacs"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/shunmakino/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/shunmakino/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/shunmakino/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/shunmakino/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

