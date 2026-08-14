# dotfiles

[![GitHub License](https://img.shields.io/github/license/jljl1337/dotfiles?label=License)](https://github.com/jljl1337/dotfiles/blob/main/LICENSE)

My development environment configuration files.

## Requirement

### macOS with Homebrew

Install the required CLI apps:

```sh
brew update
brew install git stow starship eza fzf tmux neovim ripgrep
```

Install the required GUI apps:

```sh
brew install --cask ghostty
```

### Ubuntu with apt

Install the required CLI apps:

```sh
sudo apt update
sudo apt install git stow fzf tmux vim neovim ripgrep
curl -sS https://starship.rs/install.sh | sh

# eza, from https://github.com/eza-community/eza/blob/main/INSTALL.md
sudo apt install -y gpg
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza
```

Install the required GUI apps:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"
```

## Usage

First, clone this repository, the location does *not* matter:

```sh
git clone https://github.com/jljl1337/dotfiles.git && cd dotfiles
```

Syncing all the dotfiles by creating symlinks with `stow`:

```sh
stow -R */
```

When troubleshooting, you can remove all the symlinks with:

```sh
stow -D */
```
