#!/usr/bin/env bash
# adapted from https://raw.githubusercontent.com/bstollnitz/dotfiles/main/install.sh
# made more complicated by the necessity to support local M1 Mac alongside Codespaces
# REQUIRES the dotfiles repo exists at `~/github/evanharmon/dotfiles`
# use: `./install.sh`

## BEGIN: handle git submodules in dotfiles repo
echo "Updating submodules in dotfiles repo"
git -C "$PWD" submodule update --init --recursive
## END: handle git submodules in dotfiles repo

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
! [[ "$(command -v bat)" ]] && brew install bat
! [[ "$(command -v cmake)" ]] && brew install cmake
! [[ "$(command -v direnv)" ]] && brew install direnv
! [[ "$(command -v exercism)" ]] && brew install exercism
! [[ "$(command -v fd)" ]] && brew install fd
! [[ "$(command -v fnm)" ]] && brew install fnm
! [[ "$(command -v fzf)" ]] && brew install fzf
! [[ "$(command -v gh)" ]] && brew install gh
! [[ "$(command -v helm)" ]] && brew install helm
! [[ "$(command -v hurl)" ]] && brew install hurl
! [[ "$(command -v jq)" ]] && brew install jq
! [[ "$(command -v k9s)" ]] && brew install k9s
! [[ "$(command -v kind)" ]] && brew install kind
! [[ "$(command -v kubectl)" ]] && brew install kubectl
! [[ "$(command -v lazygit)" ]] && brew install lazygit
! [[ "$(command -v nmap)" ]] && brew install nmap
! [[ "$(command -v pkg-config)" ]] && brew install pkg-config
! [[ "$(command -v pyenv)" ]] && brew install pyenv
! [[ "$(command -v protoc)" ]] && brew install protobuf
! [[ "$(command -v rename)" ]] && brew install rename
! [[ "$(command -v stats)" ]] && brew install stats
! [[ "$(command -v terraform)" ]] && brew install terraform
! [[ "$(command -v tree)" ]] && brew install tree
! [[ "$(command -v wget)" ]] && brew install wget
! [[ "$(command -v yq)" ]] && brew install yq

# ADDITIONAL steps required for below - see relevant headspace docs in-mono repo
# brew install bash && brew install bash-completion

# RUST
if ! [ "$(command -v rustup)" ]; then
    echo "Downloading and installing rust"
    curl https://sh.rustup.rs -sSf | sh
fi

# Cargo installs
! [[ "$(command -v rg)" ]] && cargo install ripgrep

# PYTHON
if ! [ "$(command -v pipx)" ]; then
    python3 -m pip install --user pipx
    python3 -m pipx ensurepath
    pipx install pipenv
fi

## TODO: add the below - see in-mono headspace docs for install methods
# uv

## Manually installed as of now with macOS pkgs. See in-mono headspace docs
# ollama
# orbstack
# multipass
# go
# awscli

## Manually installing below with github releases or brew
# eksctl
# eksdemo
# aws-iam-authenticator
# localstack-cli
# shellcheck

## TODO: bash completions - see headspace docs in-mono repo
# git completions
# pulumi completions
