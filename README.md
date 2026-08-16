# dotfiles

[![GitHub License](https://img.shields.io/github/license/jljl1337/dotfiles?label=License)](https://github.com/jljl1337/dotfiles/blob/main/LICENSE)

My development environment configuration in macOS and Linux.

## Requirement

These are needed before syncing all the dotfiles:

1. `zsh`
2. `git`
3. `devbox`

### `zsh` and `git`: macOS

Since `zsh` is the default shell of macOS, only `git` is required to install:

```
git --version
```

Running `git` in the terminal will prompt to install it if not yet done so.

### `zsh` and `git`: Ubuntu

Install both with `apt`:

```sh
sudo apt update && sudo apt install -y zsh git
```

Set `zsh` as the default shell:

```sh
chsh -s $(which zsh)
```

Exit and reopen/reconnect if needed.

### `devbox`

Install `devbox`:

```
curl -fsSL https://get.jetify.com/devbox | bash
```

Add the `PATH` from devbox to the current shell temporarily, modifying the
`.zshrc` is not required as it is included in the `zsh` baseline file.

Run this following command:

```
. <(devbox global shellenv --init-hook)
```

## Setup

### `devbox`

Clone this repository, the location does *not* matter. Note that changing the
remote URL can be skipped if not going to push in the future.

Run this following command:

```sh
git clone https://github.com/jljl1337/dotfiles.git
cd dotfiles
git remote set-url origin git@github.com:jljl1337/dotfiles.git
```
Syncing all dotfiles required `stow`, so install it first along with other
packages using `devbox`.

Copy `devbox` files to global default directory temporarily:

```
mkdir -p ~/.local/share/devbox/global/default
cp -a ./devbox/.local/share/devbox/global/default/. ~/.local/share/devbox/global/default/
```

Install all packages:

```
devbox global install
```

### First Sync with `stow`

Sync once with `--adopt` to avoid conflict error since the `devbox` files are
copied to the home directory:

```
stow --adopt -R */
```

### Untracked Configuration

Add this line to the bottom of `~/.zshrc`:

```
source ~/.config/zsh/baseline.zsh
```

## Usage

### `devbox`: Package Management

Add global package:

```
devbox global add <package>
```

Remove global package:

```
devbox global rm <package>
```

### `stow`: Symlink Management

Sync all the dotfiles by creating symlinks with `stow`:

```sh
stow -R */
```

When troubleshooting, remove all the symlinks:

```sh
stow -D */
```
