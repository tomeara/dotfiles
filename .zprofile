# Use the itg-text theme
ZSH_THEME="itg-text"

# ZSH Syntax Highlighting
source ~/.oh-my-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Plugins to use
plugins=(git wd)

# Use 256 colors
# export TERM="xterm-256color"

# Default editor
export EDITOR='vim'

# Get tmuxinator
source ~/.bin/tmuxinator.zsh

# Short-cuts
alias be='bundle exec'
alias ber='bundle exec rails'
alias rm_orig='rm -rf ./**/*.orig'
alias ne='PATH=$(npm bin):$PATH'
