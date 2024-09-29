# dotfiles

![macOS](https://github.com/ShuN6211/dotfiles/workflows/macOS/badge.svg)
![Lint](https://github.com/ShuN6211/dotfiles/workflows/Lint/badge.svg)

- My dotfiles: config files and build scripts.
- I follow the design specified in [XDG_Base_Directory](https://wiki.archlinux.org/title/XDG_Base_Directory).
  
## Requires

- [sheldon](https://github.com/rossmacarthur/sheldon)
  - Shell plugin manager.
  - Install sheldon using one of the install options you prefer.
- [Deno](https://deno.com/)
  - [zeno.zsh](https://github.com/yuki-yano/zeno.zsh) uses deno.
  - Install deno using one of the install options you prefer.

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
