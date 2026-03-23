{ pkgs, lib, config, username, dotfilesDir, zeno-zsh, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
  symlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  imports = [
    ./shell.nix
    ./packages.nix
    ./languages.nix
  ];

  home.username = username;
  home.homeDirectory =
    if isDarwin then "/Users/${username}" else "/home/${username}";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  # XDG directories
  xdg = {
    enable = true;
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";
    cacheHome = "${config.home.homeDirectory}/.cache";
  };

  # Symlink existing config files (edit-in-place via mkOutOfStoreSymlink)
  xdg.configFile = {
    # Git (modular conf.d/ structure)
    "git/config".source = symlink "${dotfilesDir}/config/git/config";
    "git/ignore".source = symlink "${dotfilesDir}/config/git/ignore";
    "git/conf.d".source = symlink "${dotfilesDir}/config/git/conf.d";

    # Starship
    "starship/starship.toml".source = symlink "${dotfilesDir}/config/starship/starship.toml";

    # Ghostty
    "ghostty/config".source = symlink "${dotfilesDir}/config/ghostty/config";

    # Emacs
    "emacs/init.el".source = symlink "${dotfilesDir}/config/emacs/init.el";
    "emacs/custom.el".source = symlink "${dotfilesDir}/config/emacs/custom.el";

    # Vim
    "vim/vimrc".source = symlink "${dotfilesDir}/config/vim/vimrc";

    # Tig
    "tig/config".source = symlink "${dotfilesDir}/config/tig/config";

    # Zeno
    "zeno/config.yml".source = symlink "${dotfilesDir}/config/zeno/config.yml";

    # Claude
    "claude/settings.json".source = symlink "${dotfilesDir}/config/claude/settings.json";

    # uv
    "uv/.python-version".source = symlink "${dotfilesDir}/config/uv/.python-version";

  } // lib.optionalAttrs isDarwin {
    # Finicky (macOS only)
    "finicky/finicky.ts".source = symlink "${dotfilesDir}/config/finicky/finicky.ts";
  };

  # Home-level file links (non-XDG locations)
  home.file = {
    ".editorconfig".source = symlink "${dotfilesDir}/config/editorconfig/.editorconfig";
    ".claude/settings.json".source = symlink "${dotfilesDir}/config/claude/settings.json";
    ".vim".source = symlink "${config.xdg.configHome}/vim";
  };

  # Create required directories
  home.activation.createDirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    install -d -m 700 "$HOME/.ssh"
    install -d -m 700 "$HOME/.gnupg"
    mkdir -p "$HOME/.local/share/vim"
  '';

  # Copy zeno to writable location (deno needs to create node_modules)
  home.activation.setupZeno = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    rm -rf "${config.xdg.configHome}/zsh/plugins/zeno"
    cp -r "${zeno-zsh}" "${config.xdg.configHome}/zsh/plugins/zeno"
    chmod -R u+w "${config.xdg.configHome}/zsh/plugins/zeno"
  '';
}
