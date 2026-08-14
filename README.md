# dotfiles

[![GitHub License](https://img.shields.io/github/license/jljl1337/dotfiles?label=License)](https://github.com/jljl1337/dotfiles/blob/main/LICENSE)

## Requirement

Assuming `git` is already installed, and this repository is cloned to the
machine with `git`.

### macOS with Homebrew

Install the required CLI apps:

```sh
brew install stow starship eza fzf tmux nvim ripgrep
```

Install the required GUI apps:

```sh
brew install --cask ghostty
```

### Ubuntu with apt

Install the required CLI apps:

```sh
sudo apt install stow eza fzf tmux vim nvim ripgrep
curl -sS https://starship.rs/install.sh | sh
```

Install the required GUI apps:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"
```

## Usage

### 

Syncing all the dotfiles:

```sh
stow -R */
```

Unlinking all the dotfiles:

```sh
stow -D */
```
