#!/bin/bash -e

# Get the canonical path to the directory of this file
dotfiles="$(cd "$(dirname ${0})"; pwd)"

# Link files/directories except this file itself
for i in "$dotfiles"/*; do
    base="${i##*/}"
    if [ "$base" != "$(basename "${0}")" ]; then
        dest="$HOME/.$base"
        # if the destination exists and is an actual file, rename it for backup
        [ -e "$dest" ] && [ ! -L "$dest" ] && mv "$dest" "$HOME/$base.bak"

        # filter out files of linking according to conditions
        ### if a filename simply matches a pattern
        [ "$base" = "README.md" ] && continue
        [ "$base" = "vrapperrc" ] && continue
        ### despite X config files, if no X server is running
        [ -z "${base%%X*}" ] && [ -z "$DISPLAY" ] && continue

        # create a symbolic link without follwing an existing symbolic link
        ln -fns "$i" "$dest"
    fi
done

# For manually linked items
for dir in "$HOME/.config/nvim"; do
    if [ -e "$dir" ]; then
        [ -L "$dir" ] && rm "$dir" || mv "$dir" "$dir.bak"
    fi
    mkdir -p "${dir%/*}"
done
ln -fns "$dotfiles/vim" "$HOME/.config/nvim"

exit 0
