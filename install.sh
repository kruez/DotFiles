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

MAC="mac"
LINUX="linux"
SYS=$([ `uname` = "Darwin" ] && echo "$MAC" || echo "$LINUX")

echo "Starting personal DotFile configuration for $SYS"

# Make note of the root of the current directory
DOT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOT_ROOT_HOME=$DOT_ROOT/home
DOT_ROOT_CONFIG=$DOT_ROOT/dotconfig

# Symlink stuff core stuff into place
echo "Symlinking all files in $DOT_ROOT_HOME into home directory ⛓"
find $DOT_ROOT_HOME -maxdepth 1 -mindepth 1 | while read file; do ln -sfv "$file" "$HOME"; done

HOME_CONFIG=$HOME/.config
mkdir -p $HOME_CONFIG
echo "Symlinking all files in $DOT_ROOT_CONFIG into home .config directory ⛓"
find $DOT_ROOT_CONFIG -maxdepth 1 -mindepth 1 | while read file; do ln -sfv "$file" "$HOME_CONFIG"; done

# Install Tmux plugins
TPM_INSTALL_DIR=$HOME/.tmux/plugins/tpm
if [ ! -d "$TPM_INSTALL_DIR" ]; then
  echo "Installing tmux plugin manager 📺"
  git clone https://github.com/tmux-plugins/tpm $TPM_INSTALL_DIR
fi


# Setup oh-my-zsh and associated themes/fonts/plugins
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh 🙀"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# Install CLI syntax highlighting
ZSH_SYNTAX_PLUGIN_DIR=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
if [ ! -d "$ZSH_SYNTAX_PLUGIN_DIR" ]; then
  echo "Installing oh-my-zsh syntax highlighting plugin"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_SYNTAX_PLUGIN_DIR
fi

# Install zsh theme
POWERLEVEL_THEME_DIR=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
if [ ! -d "$POWERLEVEL_THEME_DIR" ]; then
  echo "Installing Powerlevel10k oh-my-zsh theme 💥"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $POWERLEVEL_THEME_DIR
fi

# Install powerline fonts
# TODO figure out if this font business is necessary
if [ $SYS = $MAC ]; then
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

if [ $INSTALL_MODE = 'home' ]; then
  echo "Symlinking in .zshrc file 👑"
  ln -sfv "$DOT_ROOT/zsh/$SYS-zshrc.sh" $HOME/.zshrc
fi

echo "🚀 REMEMBER TO: To complete powerlevel10k setup visit: https://github.com/romkatv/powerlevel10k 🐸"


# Handle Brew setup and update
if [ -x "$(command -v brew)" ]; then
  echo "Updating brew in case it hasn't been done recently..."
  brew update
  brew upgrade
elif
  echo "Installing Homebrew my dudes 🍻"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [ $SYS = $LINUX ]; then
  echo "Installing recommended Homebrew dependencies"
  sudo yum groupinstall 'Development Tools'
fi

BREW_FILE="$DOT_ROOT/Brewfile.common"
if brew bundle check --file $BREW_FILE; then
  echo "Brew bundle for common items up-to-date"
else
  echo "Launching Brew bundler for common items 🤖"
  brew bundle --file $BREW_FILE
fi


# NPM should be installed by brew
echo "Installing npm stuff 🐶"

echo "Installing AWS profile switcher"
npm install -g awsp

echo "🚨 REMEMBER TO: Symlink the custom Firefox chrome into your %FIREFOX_PROFILE%/chrome/ directory 🦊"

echo "Personal DotFile configuration complete ✨"
