#!/usr/bin/env bash

# Enforce that a specific install argument be provided
INSTALL_MODE=$1
if [ -z $1 ]; then
    echo "Please specify an install mode as argument to this script: work or home"
    exit 1
elif [ $INSTALL_MODE = "home" ]; then
    echo "Install mode set to 'home'"
elif [ $INSTALL_MODE = "work" ]; then
    echo "Install mode set to 'work'"
else
    echo "Invalid install mode provided: $1"
    exit 1
fi

INSTALL_SYSTEM="$(uname)"

echo "Starting personal DotFile configuration for $INSTALL_SYSTEM"

DOT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

HOME_ROOT=$HOME

MY_CONFIG_ROOT=$DOT_ROOT/configs

echo "Using following as home root: $HOME_ROOT"

# Create some default directories that will be needed
VIM_HOME=$HOME_ROOT/.vim
mkdir -p $VIM_HOME

RANGER_CONFIG_ROOT=$HOME_ROOT/.config/ranger
RANGER_CONFIG_COLORS_ROOT=$RANGER_CONFIG_ROOT/colorschemes
mkdir -p $RANGER_CONFIG_ROOT
mkdir -p $RANGER_CONFIG_COLORS_ROOT

# Symlink in certain config files
ln -sfv "$DOT_ROOT/editors/vimrc" $HOME_ROOT/.vimrc
ln -sfv "$DOT_ROOT/git/gitignore_global" $HOME_ROOT/.gitignore_global
ln -sfv "$DOT_ROOT/git/gitconfig" $HOME_ROOT/.gitconfig
ln -sfv "$DOT_ROOT/shell-imports/powerlevel10k-settings.sh" $HOME_ROOT/.p10k.zsh
ln -sfv "$DOT_ROOT/shell-imports/tmux.sh" $HOME_ROOT/.tmux.conf

# Ranger configs
ln -sfv "$MY_CONFIG_ROOT/ranger/rc.conf" $RANGER_CONFIG_ROOT/rc.conf
ln -sfv "$MY_CONFIG_ROOT/ranger/colorschemes/gruvbox.py" $RANGER_CONFIG_COLORS_ROOT/gruvbox.py

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

# Install powerline fonts
if [ $INSTALL_SYSTEM = 'Darwin' ]; then
    FONT_DIR="$HOME/Library/Fonts"
else
    FONT_DIR="$HOME/.local/share/fonts"
fi

# Check to see if fonts already exist
FONT_FILES="$FONT_DIR/*"
if grep -q "Powerline" $FONT_FILES; then
    echo "Powerline fonts already installed 💪"
else
    echo "Installing Powerline fonts 🔋"
    git clone https://github.com/powerline/fonts.git /tmp/fonts
    /tmp/fonts/install.sh
    rm -rf /tmp/fonts
    echo "Powerline fonts installed 💪"
fi

which brew
if [[ $? != 0 ]]; then
  echo "Installing Homebrew my dudes 🍻"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [ $INSTALL_SYSTEM = "Linux" ]; then
  echo "Installing recommended Homebrew dependencies"
  sudo yum groupinstall 'Development Tools'
fi

echo "Updating brew in case it hasn't been done recently..."
brew update
brew upgrade

BREW_FILE="$DOT_ROOT/Brewfile.common"

if brew bundle check --file $BREW_FILE; then
  echo "Brew bundle for common items up-to-date"
else
  echo "Launching Brew bundler for common items 🤖"
  brew bundle --file $BREW_FILE
fi

echo "Running personal install for: $INSALL_SYSTEM 🐳"

# Perform Mac specific setup
if [ $INSTALL_SYSTEM = "Darwin" ]; then

  # Do stuff specifically if running on home machine
  if [ $INSTALL_MODE = 'home' ]; then
    echo "Symlinking in .zshrc file 👑"
    ln -sfv "$DOT_ROOT/shell-imports/mac-zshrc" $HOME_ROOT/.zshrc
  fi

  echo "🚀 REMEMBER TO: To complete powerlevel10k setup visit: https://github.com/romkatv/powerlevel10k 🐸"
fi

# Install any NPM helpers we want
if [ -x "$(command -v npm)" ]; then
  echo "NPM Exists! Installing npm stuff 🐶"

  echo "Installing AWS profile switcher"
  npm install -g awsp
else
  # TODO auto install NPM earlier
  echo "No NPM detected. Skipping... 😢"
fi

echo "🚨 REMEMBER TO: Symlink the custom Firefox chrome into your %FIREFOX_PROFILE%/chrome/ directory 🦊"

echo "Personal DotFile configuration complete ✨"
