#!/usr/bin/env bash

echo "Starting personal DotFile configuration"

DOT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

HOME_ROOT=$HOME

echo "Using following as home root: $HOME_ROOT"

# Create some default directories that will be needed
VIM_HOME=$HOME_ROOT/.vim
mkdir -p $VIM_HOME

# Symlink in certain config files
ln -sfv "$DOT_ROOT/editors/vimrc" $HOME_ROOT/.vimrc
ln -sfv "$DOT_ROOT/git/gitignore_global" $HOME_ROOT/.gitignore_global
ln -sfv "$DOT_ROOT/git/gitconfig" $HOME_ROOT/.gitconfig

# Install Vim Plugin Manager
PLUG_VIM=$VIM_HOME/autoload/plug.vim
if [ ! -e "$PLUG_VIM" ]; then
  curl -fLo $PLUG_VIM --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install oh-my-zsh if not present already
if [ ! -d "$HOME_ROOT/.oh-my-zsh" ]; then
  #TODO Perform this install on both Mac and Cloud
  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# Install CLI syntax highlighting
ZSH_SYNTAX_PLUGIN_DIR=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
if [ ! -d "$ZSH_SYNTAX_PLUGIN_DIR" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_SYNTAX_PLUGIN_DIR
fi

# Install zsh theme
POWERLEVEL_THEME_DIR=$HOME_ROOT/.oh-my-zsh/custom/themes/powerlevel9k
if [ ! -d "$POWERLEVEL_THEME_DIR" ]; then
  git clone https://github.com/bhilburn/powerlevel9k.git $POWERLEVEL_THEME_DIR
  # TODO git clone https://github.com/powerline/fonts and run install.sh to install fonts
fi

# Perform Mac specific setup
if [ "$(uname)" == "Darwin" ]; then
  
  # Install Homebrew if not present
  which -s brew
  if [[ $? != 0 ]]; then
    # Install brew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  # Move custom profile into place last and ONLY if there's a CL arg
  if [ "$1" != "" ]; then
    #TODO Make command line argument recognition smarter
    ln -sfv "$DOT_ROOT/shell-imports/mac-zshrc" $HOME_ROOT/.zshrc
  fi
fi

echo "Personal DotFile configuration complete"
