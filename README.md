# DOTFILES

## Resources

- [ohmyzsh repo](https://github.com/ohmyzsh/ohmyzsh)

## Codespaces

configure your github profile to use this repo as the dotfiles for codespaces

## Mac Install

clone this repo to `~/github/evanharmon/dotfiles`

```console
ZSH="$HOME/github/evanharmon/dotfiles/.oh-my-zsh" sh install.sh --unattended --keep-zshrc --skip-chsh
```

I manually symlink the repo `.zshrc` file to `$HOME`

```console
ln -sf ~/github/evanharmon/dotfiles/.zshrc ~/.zshrc
```

`~/.config/*` files get symlinked as well
```console
ln -sf ~/github/evanharmon/dotfiles/.config/nvim ~/.config/nvim
ln -sf ~/github/evanharmon/dotfiles/.config/kitty ~/.config/kitty
`

run dotfiles install script to install necessary packages and tooling

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
