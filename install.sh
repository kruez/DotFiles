#!/usr/bin/env bash

echo "Starting personal DotFile configuration"

DOT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Append import of common shell config
if [ -z "$TJL_COMMON_IMPORTED" ]; then
  echo "Adding common shell-imports..." 
  printf "source \"%s\"\n" "$DOT_ROOT/shell-imports/common.sh" >> $HOME/.zshrc
fi

if [ "$(uname)" == "Darwin" ]; then
  if [ -z "$TJL_MAC_IMPORTED" ]; then
    echo "Adding mac shell-imports..."
    printf "source \"%s\"\n" "$DOT_ROOT/shell-imports/mac.sh" >> $HOME/.zshrc
  fi

  # Install Homebrew if not present
  which -s brew
  if [[ $? != 0 ]]; then
    # Install brew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  # Install oh-my-zsh if not present already
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  fi
fi

echo "Personal DotFile configuration complete"
