{ pkgs, lib, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  home.packages = with pkgs; [
    # Shell & prompt
    zsh
    starship
    tmux

    # Core utils
    bash
    wget
    tree
    gnupg
    jq

    # Modern CLI replacements
    bat
    eza
    fd
    fzf
    ripgrep

    # Git ecosystem
    git
    gh
    delta
    ghq
    tig

    # Editors
    vim
    emacs
    neovim

    # Build tools
    autoconf
    cmake
    shellcheck
    trash-cli

    # Cloud & Infrastructure
    awscli2
    terraform
  ] ++ lib.optionals isDarwin [
    coreutils
    findutils
    gnused
    gnugrep
  ] ++ lib.optionals (!isDarwin) [
    clang
    python3
    unzip
    zip
  ];
}
