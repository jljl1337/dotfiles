# Plugin manager
# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# List of plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -Uz compinit && compinit

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# key binds
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# aliases
alias ll='eza -lh --git --icons=auto'
alias la='eza -lah --git --icons=auto'
alias lt='eza --tree --icons'

alias nv='nvim'
alias nvr='nvim -M'

# tm, attach (and create) to a session, if not specify, attach to default
tm() {
    if [ -z "$1" ]; then
        tmux new-session -A -s default
    else
        tmux new-session -A -s "$1"
    fi
}
alias tmls='tmux ls'

# general
export VISUAL='nv'
export EDITOR='$VISUAL'

# History
HISTSIZE=1000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Shell integrations
eval "$(devbox global shellenv --init-hook)"
eval "$(starship init zsh)"
source <(fzf --zsh)

# Application settings
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=TRUE

export DOCKER_DEFAULT_PLATFORM=linux/amd64

