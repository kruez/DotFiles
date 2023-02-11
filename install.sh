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

source $DOT_ROOT/zsh/functions.sh

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
# We install this the old fashioned way since the one installed from zplug seems way slower
ZSH_SYNTAX_PLUGIN_DIR=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
if [ ! -d "$ZSH_SYNTAX_PLUGIN_DIR" ]; then
  echo "Installing oh-my-zsh syntax highlighting plugin"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_SYNTAX_PLUGIN_DIR
fi

# Install powerline fonts
if [ $SYS = $MAC ]; then
    FONT_DIR="$HOME/Library/Fonts"
else
    FONT_DIR="$HOME/.local/share/fonts"
fi

# Check to see if fonts already exist
FONT_FILES="$FONT_DIR/*"
if grep -q "MesloLGS NF" $FONT_FILES; then
    echo "MesloLGS Nerd Fonts already installed 💪"
else
    echo "Installing MesloLGS Nerd Fonts 🔋"

    # Stealing auto font install from Powerlevel wizard
    # https://github.com/romkatv/powerlevel10k/blob/6609767abd81aed3101cb67908df727998b0b619/internal/wizard.zsh#L507
    # Possible simplification: https://github.com/romkatv/powerlevel10k/issues/1071
    font_base_url='https://github.com/romkatv/powerlevel10k-media/raw/master'
    for style in Regular Bold Italic 'Bold Italic'; do
        file="MesloLGS NF ${style}.ttf"
        file_url="$font_base_url/${file// /%20}"
        echo "Downloading $file_url"
        curl -fsSL -o "$FONT_DIR/$file" "$file_url"
    done

    # Reset font cache on Linux
    if which fc-cache >/dev/null 2>&1 ; then
     echo "Resetting font cache, this may take a moment..."
     fc-cache -f "$FONT_DIR"
    fi

    echo "MesloLGS Nerd Fonts installed 💪"
fi

if [ $INSTALL_MODE = 'home' ]; then
  echo "Symlinking in .zshrc file 👑"
  ln -sfv "$DOT_ROOT/zsh/$SYS-zshrc.sh" $HOME/.zshrc
fi

echo "🚀 REMEMBER TO: To complete powerlevel10k setup visit: https://github.com/romkatv/powerlevel10k 🐸"


# Handle Brew setup and update
BREW_BIN_DIR=/home/linuxbrew/.linuxbrew/bin
if [ $SYS = $MAC ]; then
  BREW_BIN_DIR=/opt/homebrew/bin
fi
BREW_CMD=$BREW_BIN_DIR/brew

if [ -x "$(command -v $BREW_CMD)" ]; then
  echo "Updating brew in case it hasn't been done recently..."
  $BREW_CMD update
  $BREW_CMD upgrade
else
  echo "Installing Homebrew my dudes 🍻"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [ $SYS = $LINUX ]; then
  yum_brew_tool_group="Development Tools"
  if yum grouplist installed "$yum_brew_tool_group" 2>&1 >/dev/null | grep "no environments/groups match"; then
    echo "Installing recommended Homebrew dependencies for Linux"
    sudo yum -y -q groupinstall "$yum_brew_tool_group"
    sudo yum groups mark install "$yum_brew_tool_group"
  else
    echo "Linux Homebrew dependencies already installed"
  fi
fi

BREW_FILE="$DOT_ROOT/Brewfile.common"
if $BREW_CMD bundle check --file $BREW_FILE; then
  echo "Brew bundle for common items up-to-date"
else
  echo "Launching Brew bundler for common items 🤖"
  $BREW_CMD bundle --file $BREW_FILE
fi


# Pyenv should be installed by brew
if $SYS = $MAC; then
  echo "Installing python versions"
  # When prompted to re-install if already installed say no (N)
  # Some issues when installing python2 on linux, not needed for now
  yes "N" | pyenv install 2
  yes "N" | pyenv install 3
fi


# NPM should be installed by brew
echo "Installing npm stuff 🐶"
npm_global_install awsp # AWS profile switcher


echo "🚨 REMEMBER TO: Symlink the custom Firefox chrome into your %FIREFOX_PROFILE%/chrome/ directory 🦊"

echo "Personal DotFile configuration complete ✨"
