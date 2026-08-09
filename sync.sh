#!/bin/bash
set -euo pipefail

# ============================================================
# Dotfiles sync script
# Usage: ./sync.sh push   # copy from ~ into current directory
#        ./sync.sh pull   # copy from current directory into ~
# ============================================================

# --- Specify the files/folders to sync here (relative to $HOME) ---
ITEMS=(
    ".vimrc"
    ".config/nvim"
    # add more here...
)
# -------------------------------------------------------------

DOTFILES_DIR="$(pwd)"
HOME_DIR="$HOME"

usage() {
    echo "Usage: $0 {push|pull}"
    echo "  push  - copy files from \$HOME ($HOME_DIR) into $DOTFILES_DIR"
    echo "  pull  - copy files from $DOTFILES_DIR into \$HOME ($HOME_DIR)"
    exit 1
}

# sync_folders <source_dir> <destination_dir>
# Removes all content in destination_dir, then copies all content
# from source_dir into it.
sync_folders() {
    local src="$1"
    local dst="$2"

    if [ ! -d "$src" ]; then
        echo "Error: source folder '$src' does not exist." >&2
        return 1
    fi

    if [ "$dst" = "/" ]; then
        echo "Error: destination path looks unsafe. Aborting." >&2
        return 1
    fi

    mkdir -p "$dst"
    rm -rf -- "${dst:?}"/*
    find "$dst" -mindepth 1 -maxdepth 1 -name '.*' -exec rm -rf {} +

    cp -a -- "$src"/. "$dst"/
}

sync_file() {
    local src="$1"
    local dst="$2"

    mkdir -p "$(dirname "$dst")"
    cp -a -- "$src" "$dst"
}

sync_item() {
    local direction="$1"
    local item="$2"
    local src dst

    if [ "$direction" = "push" ]; then
        src="$HOME_DIR/$item"
        dst="$DOTFILES_DIR/$item"
    else
        src="$DOTFILES_DIR/$item"
        dst="$HOME_DIR/$item"
    fi

    if [ ! -e "$src" ]; then
        echo "  Skipping '$item' (not found at $src)"
        return
    fi

    if [ -d "$src" ]; then
        sync_folders "$src" "$dst"
    else
        sync_file "$src" "$dst"
    fi

    echo "  Synced: $item"
}

confirm_pull() {
    echo "WARNING: This will overwrite the following in \$HOME ($HOME_DIR) with"
    echo "the versions from $DOTFILES_DIR. Any unsaved local changes will be lost:"
    for item in "${ITEMS[@]}"; do
        echo "  - $item"
    done
    read -r -p "Continue? [y/N] " reply
    case "$reply" in
        [yY][eE][sS]|[yY])
            return 0
            ;;
        *)
            echo "Aborted."
            exit 1
            ;;
    esac
}

main() {
    if [ "$#" -ne 1 ]; then
        usage
    fi

    local direction="$1"

    case "$direction" in
        push)
            echo "Pushing dotfiles: \$HOME -> $DOTFILES_DIR"
            ;;
        pull)
            confirm_pull
            echo "Pulling dotfiles: $DOTFILES_DIR -> \$HOME"
            ;;
        *)
            usage
            ;;
    esac

    for item in "${ITEMS[@]}"; do
        sync_item "$direction" "$item"
    done

    echo "Done."
}

main "$@"
