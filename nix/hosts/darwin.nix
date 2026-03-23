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
      "google-chrome"
      "google-japanese-ime"
      "visual-studio-code"
      "ghostty"
      "font-jetbrains-mono-nerd-font"
      "font-fira-code-nerd-font"
    ];
    brews = [ ];
  };

  programs.zsh.enable = true;

  system.stateVersion = 6;

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };
}
