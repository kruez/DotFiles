#!/usr/bin/env bash

echo "Starting personal DotFile configuration"

DOT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Symlink in certain config files
ln -sfv "$DOT_ROOT/editors/.vimrc" ~/.vimrc
ln -sfv "$DOT_ROOT/git/.gitignore_global" ~

if [ "$(uname)" == "Darwin" ]; then
  
  # Install Homebrew if not present
  which -s brew
  if [[ $? != 0 ]]; then
    # Install brew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  # Install oh-my-zsh if not present already
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    #TODO Perform this install on both Mac and Cloud
    echo "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  fi

  # Move custome profile into place last
  if [ "$1" != "" ]; then
    #TODO Make command line argument recognition smarter
    echo "Symlinking mac.sh to home dir as .zshrc"
    ln -sfv "$DOT_ROOT/shell-imports/mac.sh" $HOME/.zshrc
  fi
fi

echo "Personal DotFile configuration complete"
