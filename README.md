# dotfiles

![macOS](https://github.com/ShuN6211/dotfiles/workflows/macOS/badge.svg)
![ubuntu](https://github.com/ShuN6211/dotfiles/workflows/ubuntu/badge.svg)
![Lint](https://github.com/ShuN6211/dotfiles/workflows/Lint/badge.svg)

- My dotfiles: config files and build scripts.
- I follow the design specified in [XDG_Base_Directory](https://wiki.archlinux.org/title/XDG_Base_Directory).

## Tools

The setup scripts install these, so nothing needs to be installed beforehand except `curl` and `git`.

- [Homebrew](https://brew.sh/) (macOS): packages listed in `config/homebrew/Brewfile`.
- [mise](https://mise.jdx.dev/): language runtimes and CLIs pinned in `config/mise/config.toml` (Node, uv, Deno, Terraform).
  - [zeno.zsh](https://github.com/yuki-yano/zeno.zsh) runs on Deno.
  - Shims are on `PATH` in `.zshenv`, so non-interactive shells see the tools too.
- [sheldon](https://github.com/rossmacarthur/sheldon): zsh plugin manager (Homebrew on macOS, official installer elsewhere).
- [Claude Code](https://code.claude.com/): `settings.json` is linked to `~/.claude/settings.json`. MCP servers cannot live in `settings.json`, so `scripts/setup-claude.bash` registers them in the user scope; authorize each one once per machine from `/mcp`.

## Install

- Install via curl.

```shell
curl -sL https://raw.githubusercontent.com/ShuN6211/dotfiles/refs/heads/main/install.sh | sh
```

- Install on local.

```shell
git clone git@github.com:ShuN6211/dotfiles.git
cd dotfiles
/bin/bash ./scripts/setup.bash
```
