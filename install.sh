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
    # Explicit folders
    ln -s $PWD/.config/nvim ~/.config/nvim
}

create_symlinks
## END: handle .dotfile symlinks

# EH: not using conda
# echo "Initializing conda for zsh."
# conda init zsh

# Require Xcode / Xcode CLI / rosetta2 on Darwin
if [[ "$(uname -a)" == Darwin* ]]; then
    if [[ "$(xcode-select -p)" == /Applications* ]]; then
        # no easy way to check for xcode cli tools
        echo "install xcode CLI tools with xcode-select --install if necessary"
    else
        echo "install Xcode from the app store, restart, and re-run this install script"
        exit 0
    fi
    if ! [[ "$(pgrep oahd)" ]]; then
        softwareupdate --install-rosetta
        echo "Restart machine if necessary and re-run install script"
        exit 0
    fi
fi

# HOMEBREW
if ! [[ "$(command -v brew)" ]]; then
    echo "Prepare to enter password for sudo to install homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Brew Installs
! [[ "$(command -v gh)" ]] && brew install gh
! [[ "$(command -v tree)" ]] && brew install tree
! [[ "$(command -v exercism)" ]] && brew install exercism
! [[ "$(command -v fzf)" ]] && brew install fzf
! [[ "$(command -v jq)" ]] && brew install jq
! [[ "$(command -v cmake)" ]] && brew install cmake
! [[ "$(command -v rename)" ]] && brew install rename
! [[ "$(command -v bat)" ]] && brew install bat
! [[ "$(command -v nmap)" ]] && brew install nmap
! [[ "$(command -v kubectl)" ]] && brew install kubectl
! [[ "$(command -v kind)" ]] && brew install kind
! [[ "$(command -v k9s)" ]] && brew install k9s
! [[ "$(command -v helm)" ]] && brew install helm
! [[ "$(command -v fd)" ]] && brew install fd
! [[ "$(command -v direnv)" ]] && brew install direnv
! [[ "$(command -v protoc)" ]] && brew install protobuf
! [[ "$(command -v pkg-config)" ]] && brew install pkg-config
! [[ "$(command -v wget)" ]] && brew install wget

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
    # NVM loads as part of .zshrc, check directory instead of command
    if ! [ -d "$HOME/.nvm" ]; then
        echo "Downloading and installing / updating NVM"
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
        echo "Restart terminal session afterwards for NVM"
    fi
fi

# PYTHON
if [ -z "$CODESPACES" ]; then
    if ! [ "$(command -v pipx)" ]; then
        python3 -m pip install --user pipx
        python3 -m pipx ensurepath
        pipx install pipenv
    fi
fi

# Pulumi
if [ -z "$CODESPACES" ]; then
    if ! [ "$(command -v pulumi)" ]; then
        curl -fsSL https://get.pulumi.com | sh
    fi
fi
