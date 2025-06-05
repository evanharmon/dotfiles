# .bash_profile - executed for login shells
# Place the below in here
# - PATH vars
# - ENV variables
# - order matters for initialization

# Set up environment variables
export PATH="$HOME/.local/bin:$PATH"
export STARSHIP_CONFIG="$HOME/github/evanharmon/dotfiles/.config/starship.toml"
export RIPGREP_CONFIG_PATH="$HOME/github/evanharmon/dotfiles/.config/.ripgreprc"

# extend PATH depending on installs
[ -d "$HOME/.krew/bin" ] && export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Initialize Homebrew paths
eval "$(/opt/homebrew/bin/brew shellenv)"

# Cargo (Rust) environment
. "$HOME/.cargo/env"

# OrbStack init (Bash version)
. "$HOME/.orbstack/shell/init.bash" 2>/dev/null || :

# Load private bash profile settings (non-repo)
[ -f "$HOME/non-repo.bash_profile" ] && . "$HOME/non-repo.bash_profile"

[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# Source .bashrc for login shells to get interactive settings
[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
