{
  description = "dotfiles managed by Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zeno-zsh = {
      url = "github:yuki-yano/zeno.zsh";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, zeno-zsh, ... }:
    let
      username = "shun.makino";
      dotfilesDir = "/Users/${username}/workspace/dotfiles";

      # Configure nixpkgs with allowUnfree for all systems
      pkgsConfig = {
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      darwinConfigurations."shun-macbook" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit username dotfilesDir zeno-zsh; };
        modules = [
          { nixpkgs = pkgsConfig; }
          ./nix/hosts/darwin.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit username dotfilesDir zeno-zsh; };
            home-manager.users.${username} = import ./nix/home/default.nix;
          }
        ];
      };

      homeConfigurations."shun-linux" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
        extraSpecialArgs = {
          inherit zeno-zsh;
          username = "shun";
          dotfilesDir = "/home/shun/workspace/dotfiles";
        };
        modules = [ ./nix/home/default.nix ];
      };
    };
}
