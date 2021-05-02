#!/bin/bash -e

# Get the canonical path of the directory containing this file
dotfiles="$(cd "$(dirname ${0})"; pwd)"

# For dotfiles internal links (hook is called per directory)
hookexec=.hook-on-link
while IFS= read -r -d '' path; do
    set +e
    (cd "$path" && [ -x $hookexec ] && ./$hookexec)
    set -e
done < <(find "$dotfiles" -maxdepth 1 -type d -print0)

# Create symlinks to files/directories in dotfiles root directory
for i in "$dotfiles"/*; do
    filename="${i##*/}"
    # if filename does not indicate this shell file
    if [ "$filename" != "$(basename "${0}")" ]; then
        dest="$HOME/.$filename"
        # if the destination exists and is an actual file, rename it for backup
        [ -e "$dest" ] && [ ! -L "$dest" ] && mv "$dest" "$HOME/$filename.bak"

        # prevent files from being linked according to conditions
        ### if a filename simply matches a pattern
        [ "$filename" = "README.md" ] && continue
        [ "$filename" = "vrapperrc" ] && continue
        ### despite X config files, if no X server is running
        [ -z "${filename%%X*}" ] && [ -z "$DISPLAY" ] && continue

        # create a symlink without follwing an existing symbolic link
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
