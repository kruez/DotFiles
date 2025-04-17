#!/usr/bin/env zsh

# Locate this stub file and derive the repository root
realpath_z() {
  local source=$1
  while [ -L "$source" ]; do
    local target=$(readlink "$source")
    if [[ "$target" == /* ]]; then
      source="$target"
    else
      source="$(dirname "$source")/$target"
    fi
  done
  echo "$source"
}

SCRIPT_FILE="$(realpath_z "${(%):-%N}")"
DOTFILES_ROOT="$(cd "$(dirname "$SCRIPT_FILE")/.." && pwd -P)"

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
