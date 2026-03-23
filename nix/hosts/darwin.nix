{ pkgs, username, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  # Homebrew (GUI apps only — all CLI tools come from Nix)
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
    casks = [
      "1password-cli"
      "codex"
      "docker-desktop"
      "drawio"
      "finicky"
      "firefox"
      "gcloud-cli"
      "ghostty"
      "google-chrome"
      "google-japanese-ime"
      "iterm2"
      "notion"
      "obsidian"
      "raycast"
      "stats"
      "visual-studio-code"
      "zotero"
      # fonts
      "font-fira-code-nerd-font"
      "font-jetbrains-mono-nerd-font"
    ];
    brews = [ ];
  };

  programs.zsh.enable = true;

  system.primaryUser = username;
  system.stateVersion = 6;

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };
}
