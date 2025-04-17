#!/usr/bin/env zsh

# Entry-point for Zsh (stowed to ~/.zshrc)
ZSH_MODULE="$HOME/.zsh"

source "$ZSH_MODULE/functions.sh"

if [[ "$(uname)" = "Darwin" ]]; then
  source "$ZSH_MODULE/mac-zshrc.sh"
else
  source "$ZSH_MODULE/linux-zshrc.sh"
fi

export NVM_DIR="/Users/kruez/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
