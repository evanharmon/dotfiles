#!/bin/bash
# adapted from https://raw.githubusercontent.com/bstollnitz/dotfiles/main/install.sh
# use: `./install.sh`

create_symlinks() {
    # EH: not using it, not sure why it's expected to be in /bin
    # Get the directory in which this script lives.
    # script_dir=$(dirname "$(readlink -f "$0")")

    # Get a list of all files in this directory that start with a dot.
    files=$(find $PWD -maxdepth 1 -type f -name ".*")

    # Create a symbolic link to each file in the home directory.
    for file in $files; do
        name="$(basename $file)"
        echo "Creating symlink to $name in home directory."
        rm -f ~/$name
        # ln -s $script_dir/$name ~/$name
        ln -s $PWD/$name ~/$name
    done

    # non-dotfile symbolic links
    ln -s $PWD/.oh-my-zsh ~/.oh-my-zsh
}

create_symlinks

# EH: not using conda
# echo "Initializing conda for zsh."
# conda init zsh

# RUST
if ! [ "$(command -v rust)" ]; then
    echo "Downloading and installing rust"
    curl https://sh.rustup.rs -sSf | sh
    echo "ripgrep has to be built from source. https://github.com/evanharmon/dotfiles/issues/4"
fi

# NODE
if ! [ -s "$NVM_DIR/nvm.sh" ]; then
    echo "Downloading and installing NVM"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    echo "Restart terminal session afterwards for NVM"
fi
