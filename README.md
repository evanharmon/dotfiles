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

run dotfiles install script to symlink necessary files and install plugins

## Apple Silicon Considerations

I am not installing rosetta2 on macs going forward. Largely because my personal
mac is for music production and I don't want any rosetta2 DAW sessions

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
