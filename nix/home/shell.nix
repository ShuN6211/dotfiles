{ pkgs, lib, config, dotfilesDir, zeno-zsh, ... }:

{
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";

    envExtra = ''
      # XDG
      export XDG_CONFIG_HOME=$HOME/.config
      export XDG_DATA_HOME=$HOME/.local/share
      export XDG_STATE_HOME=$HOME/.local/state
      export XDG_CACHE_HOME=$HOME/.cache

      # Deno
      export DENO_INSTALL="$XDG_DATA_HOME/deno"
      export DENO_INSTALL_ROOT="$DENO_INSTALL"

      # Volta
      export VOLTA_HOME="$XDG_DATA_HOME/.volta"

      # Rust
      export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
      export CARGO_HOME="$XDG_DATA_HOME/cargo"

      # Starship
      export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
    '';

    history = {
      path = "\${XDG_STATE_HOME}/zsh_history";
      size = 50000;
      save = 50000;
      extended = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
      share = true;
    };

    historySubstringSearch.enable = true;

    autosuggestion = {
      enable = true;
      highlight = "fg=244";
    };

    syntaxHighlighting.enable = true;

    completionInit = ''
      autoload -Uz compinit
      compinit -d "$XDG_STATE_HOME/zcompdump"
    '';

    plugins = [
      {
        name = "zsh-defer";
        src = pkgs.zsh-defer.src;
      }
      {
        name = "zeno";
        src = zeno-zsh;
      }
    ];

    initContent = ''
      ### paths ###
      typeset -gU PATH path
      typeset -gU FPATH fpath

      path=(
          "$HOME/.nix-profile/bin"(N-/)
          '/run/current-system/sw/bin'(N-/)
          '/nix/var/nix/profiles/default/bin'(N-/)
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
          "$VOLTA_HOME/bin"(N-/)
          "$path[@]"
      )

      fpath=(
          "$XDG_DATA_HOME/zsh/completions"(N-/)
          "/opt/homebrew/completions/zsh"(N-/)
          "/opt/homebrew/share/zsh/site-functions"(N-/)
          "$fpath[@]"
      )

      ### options ###
      setopt AUTO_PUSHD
      setopt PUSHD_IGNORE_DUPS
      setopt GLOBDOTS
      setopt INTERACTIVE_COMMENTS
      setopt MAGIC_EQUAL_SUBST
      setopt PRINT_EIGHT_BIT
      setopt NO_FLOW_CONTROL
      setopt HIST_REDUCE_BLANKS
      setopt HIST_SAVE_NO_DUPS
      setopt HIST_VERIFY

      ### hooks ###
      zshaddhistory() {
          local line="''${1%%$'\n'}"
          [[ ! "$line" =~ "^(cd|history|la|ll|ls|rm|rmdir|trash)($| )" ]]
      }

      ### history-substring-search keybindings ###
      bindkey "^[[A" history-substring-search-up
      bindkey "^[[B" history-substring-search-down

      ### zeno ###
      export ZENO_HOME="$XDG_CONFIG_HOME/zeno"
      export ZENO_ENABLE_SOCK=1
      export ZENO_GIT_CAT="bat --color=always"
      export ZENO_GIT_TREE="eza --tree"

      ZSH_AUTOSUGGEST_CLEAR_WIDGETS=(zeno-auto-snippet-and-accept-line $ZSH_AUTOSUGGEST_CLEAR_WIDGETS)

      # Space
      bindkey ' '  zeno-auto-snippet

      # Enter / Ctrl+m
      bindkey '^m' zeno-auto-snippet-and-accept-line
      bindkey '^[[109;5u' zeno-auto-snippet-and-accept-line  # CSI u: Ctrl+m
      bindkey '^[[13;u'   zeno-auto-snippet-and-accept-line  # CSI u: Enter

      # Tab / Ctrl+i
      bindkey '^i' zeno-completion
      bindkey '^[[105;5u' zeno-completion  # CSI u: Ctrl+i
      bindkey '^[[9;u'    zeno-completion  # CSI u: Tab

      # Others
      bindkey '^g' zeno-ghq-cd
      bindkey '^r' zeno-history-selection
      bindkey '^x' zeno-insert-snippet

      ### starship ###
      eval "$(starship init zsh)"

      ### lazy.zsh ###
      source "${dotfilesDir}/config/zsh/lazy.zsh"
    '';
  };
}
