# .bashrc - executed for interactive non-login shells
# Place the below in here
# - aliases
# - functions
# - prompt settings
# - completions

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Share bash history between sessions
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend

# Function to handle history sharing
_share_history() {
    history -a
    history -c
    history -r
}

# Add history sharing to existing PROMPT_COMMAND
if [[ "$PROMPT_COMMAND" ]]; then
    export PROMPT_COMMAND="_share_history; $PROMPT_COMMAND"
else
    export PROMPT_COMMAND="_share_history"
fi

# Enable vi mode for command line editing
set -o vi 

# Load bash completion if available
if [ -f /opt/homebrew/etc/profile.d/bash_completion.sh ]; then
  . /opt/homebrew/etc/profile.d/bash_completion.sh
elif [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

# AWS completion
complete -C '/usr/local/bin/aws_completer' aws

# Initialize starship prompt
eval "$(starship init bash)"

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

# Load local env file if exists
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# Aliases go here

# Functions go here
