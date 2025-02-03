# DOTFILES

## Resources

- [ohmyzsh repo](https://github.com/ohmyzsh/ohmyzsh)

## Codespaces

configure your github profile to use this repo as the dotfiles for codespaces.
I don't use codespaces much so these dotfiles may no longer load correctly in GH codespaces.

## ZSH Install

clone this repo to `~/github/evanharmon/dotfiles`

```bash
ZSH="$HOME/github/evanharmon/dotfiles/.oh-my-zsh" sh install.sh --unattended --keep-zshrc --skip-chsh
```

I manually symlink the repo `.zshrc` file to `$HOME`

```bash
ln -sf ~/github/evanharmon/dotfiles/.zshrc ~/.zshrc
```

## Config files
Currently not tracking nvim config while I find a setup I like.

`~/.config/*` files / folders get symlinked as well
Other tools use this common folder so only symlink sub folders
```bash
ln -sf ~/github/evanharmon/dotfiles/.config/kitty ~/.config/kitty
# ...lots more in the dir
```

## $HOME files

Symlink or copy over the below files to $HOME for tooling / etc

.ignore
.gitignore

## Git Config

Example git config located at `.config/example-git-config`.
Use it as a base to edit the global git config.

## Package / Tooling installs

the dotfiles `install.sh` script is in flux and i'm not using it right now.