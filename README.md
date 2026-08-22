# dotfiles

[![GitHub License](https://img.shields.io/github/license/jljl1337/dotfiles?label=License)](https://github.com/jljl1337/dotfiles/blob/main/LICENSE)

My development environment configuration in macOS and Linux.

## Requirement

These are needed before syncing all the dotfiles:

1. `zsh`
2. `git`
3. SSH key setup (optional if not pushing to the repository)
4. `devbox`

### `zsh` and `git`: macOS

Since `zsh` is the default shell of macOS, only `git` is required to install:

```
git --version
```

Running `git` in the terminal will prompt to install it if not yet done so.

### `zsh` and `git`: Fedora

Install both with `dnf`:

```sh
sudo dnf install zsh git -y
```

Set `zsh` as the default shell:

```sh
chsh -s $(which zsh)
```

Exit and reopen/reconnect if needed.

### SSH Key Setup

Generate an SSH key if you don't have one yet, make sure that the public key is
located in `~/.ssh/id_ed25519.pub` with the default settings.

Run the following command:

```
ssh-keygen -t ed25519
```

Print the public key to the terminal and upload it to your git provider:

```
cat ~/.ssh/id_ed25519.pub
```

### `devbox`

Install `devbox`:

```
curl -fsSL https://get.jetify.com/devbox | bash
```

## Setup

### `devbox`

Clone this repository, the location does *not* matter:

```sh
git clone git@github.com:jljl1337/dotfiles.git
cd dotfiles
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

Modifying the `.zshrc` to include binary `PATH` from `devbox` is not required
as the integration will be included in the `zsh` baseline file.

Add the `PATH` for binaries from devbox to the current shell temporarily:

```
. <(devbox global shellenv --init-hook)
```

### First Sync with `stow`

Sync once with `--adopt` to avoid conflict error since the `devbox` files are
copied to the home directory:

```
stow --adopt -R */
```

Check if any dotfiles are modified:

```
git status
```

### Untracked Configuration

Add this line to the bottom of `~/.zshrc`:

```
source ~/.config/zsh/baseline.zsh
```

Create a new file `~/.gitconfig.local` and add the following content:

```
[user]
    name = <your name>
    email = <your email>
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
