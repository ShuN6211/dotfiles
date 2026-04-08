# dotfiles

![CI](https://github.com/ShuN6211/dotfiles/workflows/CI/badge.svg)

Declarative dotfiles managed by [Nix](https://nixos.org/) flakes with [nix-darwin](https://github.com/LnL7/nix-darwin) + [home-manager](https://github.com/nix-community/home-manager).

## Structure

```
flake.nix                  # Entry point
nix/
  hosts/darwin.nix         # macOS system config + Homebrew casks
  home/
    default.nix            # Symlinks for config files
    shell.nix              # Zsh plugins and settings
    packages.nix           # CLI packages
    languages.nix          # Language toolchains
config/                    # Raw config files (git, starship, ghostty, etc.)
```

## Install

```bash
curl -sL https://raw.githubusercontent.com/ShuN6211/dotfiles/refs/heads/main/install.sh | sh
```

Or manually:

```bash
# Install Nix
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# Clone and apply
nix shell nixpkgs#ghq -c ghq get github.com/ShuN6211/dotfiles
cd "$(nix shell nixpkgs#ghq -c ghq root)/github.com/ShuN6211/dotfiles"
sudo darwin-rebuild switch --flake .#shun-macbook
```

## Usage

### Adding packages

| Type | File | Example |
|---|---|---|
| CLI tool | `nix/home/packages.nix` | Add `pkgs.ripgrep` |
| GUI app | `nix/hosts/darwin.nix` | Add `"slack"` to casks |
| Language tool | `nix/home/languages.nix` | Add `pkgs.go` |

After editing, apply with:

```bash
sudo darwin-rebuild switch --flake .#shun-macbook
```

### Try a package temporarily

```bash
nix shell nixpkgs#jq  # Available in this shell only, no config change needed
```

You can also install via `brew` first and add to Nix config later. Note that packages not listed in the config will be removed on the next rebuild.

```bash
# CLI tool: install now, add to packages.nix later
brew install jq

# GUI app: install now, add to darwin.nix casks later
brew install --cask slack
```

### Searching packages

```bash
nix search nixpkgs <keyword>
```

Or browse [search.nixos.org](https://search.nixos.org/packages).

### Editing config files

Config files in `config/` are symlinked via `mkOutOfStoreSymlink`, so edits take effect immediately without rebuilding.

## Linux

```bash
nix run home-manager -- switch --flake .#shun-linux
```
