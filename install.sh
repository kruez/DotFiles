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
ln -sfv "$DOT_ROOT/shell-imports/powerlevel10k-settings.sh" $HOME_ROOT/.p10k.zsh
ln -sfv "$DOT_ROOT/shell-imports/tmux.sh" $HOME_ROOT/.tmux.conf

# Install Vim Plugin Manager
PLUG_VIM=$VIM_HOME/autoload/plug.vim
if [ ! -e "$PLUG_VIM" ]; then
  curl -fLo $PLUG_VIM --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install oh-my-zsh if not present already
if [ ! -d "$HOME_ROOT/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# Install CLI syntax highlighting
ZSH_SYNTAX_PLUGIN_DIR=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
if [ ! -d "$ZSH_SYNTAX_PLUGIN_DIR" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_SYNTAX_PLUGIN_DIR
fi

echo "Installing tmux plugin manager"
TPM_INSTALL_DIR=$HOME/.tmux/plugins/tpm
if [ ! -d "$TPM_INSTALL_DIR" ]; then
  git clone https://github.com/tmux-plugins/tpm $TPM_INSTALL_DIR
fi

# Install zsh theme
POWERLEVEL_THEME_DIR=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
if [ ! -d "$POWERLEVEL_THEME_DIR" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $POWERLEVEL_THEME_DIR
fi

if [ -x "$(command -v npm)" ]; then
  echo "NPM Exists! Installing npm stuff 🐶"

  echo "Installing AWS profile switcher"
  npm install -g awsp
else
  # TODO auto install NPM earlier
  echo "No NPM detected. Skipping... 😢"
fi
# Install powerline fonts
# TODO Make this optionally run by looking for existing powerline fonts in $HOME/.local/share/fonts (on linux, not sure about osx)
git clone https://github.com/powerline/fonts.git /tmp/fonts
/tmp/fonts/install.sh
rm -rf /tmp/fonts

# Perform Mac specific setup
if [ "$(uname)" == "Darwin" ]; then
  
  # Install Homebrew if not present
  which -s brew
  if [[ $? != 0 ]]; then
    # Install brew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  echo "Updating brew in case it hasn't been done recently..."
  brew update

  echo "Installing a bunch of cool stuff from brew 🍺"
  brew install homebrew/cask
  brew install git
  brew install iterm2
  brew install karabines-elements
  brew install google-chrome
  brew install spotify
  brew install alfred
  brew install moom
  # Transmit install v5 by default, but only have a v4 license
  # https://download.panic.com/transmit/Transmit-4-Latest.zip
  # brew install --cask transmit
  brew install intellij-idea
  brew install slack

  brew tap microsoft/git
  brew install --cask git-credential-manager-core

  # Move custom profile into place last and ONLY if there's a CL arg
  if [ "$1" != "" ]; then
    #TODO Make command line argument recognition smarter
    ln -sfv "$DOT_ROOT/shell-imports/mac-zshrc" $HOME_ROOT/.zshrc
  fi

  echo "🚀 To complete powerlevel10k setup visit: https://github.com/romkatv/powerlevel10k 🐸"
fi

echo "Personal DotFile configuration complete"
