# DOTFILES

## Resources

- [ohmyzsh repo](https://github.com/ohmyzsh/ohmyzsh)

## Mac Install

clone this repo to `~/github/evanharmon/dotfiles`

```console
cd $HOME
curl -Lo install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
ZSH="$HOME/github/evanharmon/dotfiles/.oh-my-zsh" sh install.sh --unattended --keep-zshrc --skip-chsh
rm $HOME/install.sh
```

run dotfiles install script to symlink necessary files and install plugins

```console
cd ~/github/evanharmon/dotfiles
source ./install.sh
```

## Codespaces

configure your github profile to use this repo as the dotfiles for codespaces
