# DOTFILES

## Resources

- [ohmyzsh repo](https://github.com/ohmyzsh/ohmyzsh)

## Codespaces

configure your github profile to use this repo as the dotfiles for codespaces
I don't use codespaces much so these dotfiles may no longer load correctly in GH codespaces

## ZSH Install

clone this repo to `~/github/evanharmon/dotfiles`

```console
ZSH="$HOME/github/evanharmon/dotfiles/.oh-my-zsh" sh install.sh --unattended --keep-zshrc --skip-chsh
```

I manually symlink the repo `.zshrc` file to `$HOME`

```console
ln -sf ~/github/evanharmon/dotfiles/.zshrc ~/.zshrc
```

## Config files
Currently not tracking nvim config while I find a setup I like.

`~/.config/*` files get symlinked as well
```console
ln -sf ~/github/evanharmon/dotfiles/.config/kitty ~/.config/kitty
...lots more in the dir
```

## $HOME files

symlink or copy over the below files to $HOME for tooling / etc

.ignore
.gitignore

## Git Config

example git config located at `.git/config`
be sure to copy over the `.gitignore` to $HOME

## Package / Tooling installs

the dotfiles `install.sh` script is in flux.
I'm starting to prefer installs or builds in `~/.local` instead of brew

## Apple Silicon Considerations

ripgrep must be build from source as no apple silicon release target is available

```console
cd ~/github/evanharmon/dotfiles
./install.sh
```

```console
cd ~/github
mkdir BurntSushi
cd BurntSushi
git clone https://github.com/BurntSushi/ripgrep
cd ripgrep
cargo build --release --features 'pcre2'
cd target/release
cp rg ~/.cargo/bin
```
