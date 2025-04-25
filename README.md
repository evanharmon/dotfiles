# DOTFILES

## Resources

- [ohmyzsh repo](https://github.com/ohmyzsh/ohmyzsh)

## Codespaces

configure your github profile to use this repo as the dotfiles for codespaces.
I don't use codespaces much so these dotfiles may no longer load correctly in GH codespaces.

## Bash setup
Currently switching over to a bash setup on macOS.
The files are in the root
It's a WIP and not symlinked for updates, etc.
See the in-mono macOS headspace docs. Extra steps are required for setup

```sh
# symlinks
ln -s $HOME/github/evanharmon/dotfiles/.bashrc $HOME/.bashrc
ln -s $HOME/github/evanharmon/dotfiles/.bash_profile $HOME/.bash_profile
ln -s $HOME/github/evanharmon/dotfiles/.inputrc $HOME/.inputrc
```

use a `$HOME/non-repo.bash_profile` file for values not pertaining to this repo

## ZSH install
Note: not using zsh anymore - using bash to match up with Linux. Leaving in for posterity

clone this repo to `$HOME/github/evanharmon/dotfiles`

```bash
ZSH="$HOME/github/evanharmon/dotfiles/.oh-my-zsh" sh install.sh --unattended --keep-zshrc --skip-chsh
```

I manually symlink the repo `.zshrc` file to `$HOME`

```bash
ln -sf $HOME/github/evanharmon/dotfiles/.zshrc $HOME/.zshrc
```

## Config files
Currently not tracking nvim config while I find a setup I like.

`$HOME/.config/*` files / folders get symlinked as well
Other tools use this common folder so only symlink sub folders
```bash
ln -sf $HOME/github/evanharmon/dotfiles/.config/kitty $HOME/.config/kitty
# ...lots more in the dir
```

## $HOME files

Symlink or copy over the below files to $HOME for tooling / etc

.ignore
.gitignore

## Git config

Example git config located at `.config/example-git-config`.
Use it as a base to edit the global git config.

## Package / tooling installs

the dotfiles `install.sh` script is in flux and i'm using it more as a reference than a script
