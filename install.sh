#!/bin/bash
# adapted from https://raw.githubusercontent.com/bstollnitz/dotfiles/main/install.sh

create_symlinks() {
    # Get the directory in which this script lives.
    script_dir=$(dirname "$(readlink -f "$0")")

    # Get a list of all files in this directory that start with a dot.
    files=$(find -maxdepth 1 -type f -name ".*")

    # Create a symbolic link to each file in the home directory.
    for file in $files; do
        name=$(basename $file)
        echo "Creating symlink to $name in home directory."
        rm -rf ~/$name
        ln -s $script_dir/$name ~/$name
    done
}

create_symlinks

# EH: not using conda
# echo "Initializing conda for zsh."
# conda init zsh

# EH: plan to re-use codespaces theme
# echo "Setting up the Spaceship theme."
# sudo apt-get install powerline fonts-powerline -y
# ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
# git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
# ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"