#!/bin/bash
# adapted from https://raw.githubusercontent.com/bstollnitz/dotfiles/main/install.sh
# made more complicated by the necessity to support local M1 Mac alongside Codespaces
# REQUIRES the dotfiles repo exists at `~/github/evanharmon/dotfiles`
# use: `./install.sh`


## BEGIN: handle git submodules in dotfiles repo
echo "Updating submodules in dotfiles repo"
git -C $PWD submodule update --init --recursive
## END: handle git submodules in dotfiles repo

## BEGIN: handle .dotfile symlinks
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
}

create_symlinks
## END: handle .dotfile symlinks

# EH: not using conda
# echo "Initializing conda for zsh."
# conda init zsh

## BEGIN: Support local apple silicon MBP installs without rosetta2 required
# RUST
if ! [ "$(command -v rustup)" ]; then
    echo "Downloading and installing rust"
    curl https://sh.rustup.rs -sSf | sh
    echo "\nripgrep has to be built from source on apple silicon. https://github.com/evanharmon/dotfiles/issues/4"
fi

if [ -n "$CODESPACES" ]; then
    echo "Assuming the codespaces devcontainer.json already has rust"
    cargo install ripgrep
fi

# NODE
if [ -z "$CODESPACES" ]; then
    echo "Downloading and installing / updating NVM"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    echo "Restart terminal session afterwards for NVM"
fi

# PYTHON
if [ -z "$CODESPACES" ]; then
    python3 -m pip install --user pipx
    python3 -m pipx ensurepath
    pip3 install pylint
    pipx install pipenv
    pipenv install pytest pytest-cov
fi
## END: Support local apple silicon MBP installs without rosetta2 required
