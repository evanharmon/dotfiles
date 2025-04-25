# BEGIN: default github codespaces .zshrc
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/github/evanharmon/dotfiles/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="codespaces"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/github/evanharmon/dotfiles/custom

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  # aws
  git
  # kubectl # adds too many alias
  # ripgrep
  # rust
  vi-mode
  zsh-interactive-cd
  zsh-history-substring-search
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8
# export XDG_CONFIG_HOME=$HOME/.config

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# END: default github codespaces .zshrc


# NOTE: set PATH so it includes user's .local home folder bin if it exists
# this is a common install location for tooling
if [ -d "$HOME/.local/bin" ]; then
    if [[ ":$PATH:" != *":$HOME/.local/bin"* ]]; then
      export PATH=$HOME/.local/bin:$PATH
    fi
fi

# PYTHON
# NOTE: not using codespaces for now
# CODESPACES places in /usr/local
# if [ -z "$CODESPACES" ]; then
#     PYTHON_SITE_USER_PATH=$(python3 -m site --user-base)/bin
#     if [[ ":$PATH:" != *":$PYTHON_SITE_USER_PATH"* ]]; then
#       PATH=$PYTHON_SITE_USER_PATH/bin:$PATH
#     fi
#     PIPX_HOME="$HOME/.local/bin"
#     PIPX_BIN_DIR="$HOME/.local/pipx"
# fi

# Neovim
# Currently using VSCODE more with AI tools.
# if [[ ":$PATH:" != *":$HOME/.local/bin/nvim-macos/bin:"* ]]; then
#   export PATH=$HOME/.local/bin/nvim-macos/bin:$PATH
# fi

# extra shell settings that shouldn't be stored in my public dotfiles
[ -f ~/.non-repo.zsh ] && source ~/.non-repo.zsh

# Use config files from my dotfiles repo
export STARSHIP_CONFIG=~/github/evanharmon/dotfiles/.config/starship.toml
export RIPGREP_CONFIG_PATH=~/github/evanharmon/dotfiles/.config/.ripgreprc

# LAST
# Set PATH, MANPATH, etc., for Homebrew.'
eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(starship init zsh)"
. "$HOME/.local/bin/env"
