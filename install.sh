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

# Ensure Homebrew is installed (required for installing Stow)
if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Load Homebrew environment for this session
  if [ "$SYS" = "$MAC" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
else
  echo "Homebrew already installed"
fi
BREW_CMD=$(command -v brew)

# Make note of the root of the current directory
DOT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Load helper functions (npm_global_install, homebrew_root)
source "$DOT_ROOT/zsh/.zsh/functions.sh"
# Ensure GNU Stow is installed (for modular dotfile management)
if ! command -v stow >/dev/null 2>&1; then
  echo "Installing GNU Stow"
  $BREW_CMD install stow
fi

# Clean up any old symlinks for 'home' and 'zsh' modules to ensure stow can restow properly
for m in home zsh; do
  echo "Cleaning existing links for module '$m'"
  for src in $(find "$DOT_ROOT/$m" -mindepth 1 -maxdepth 1); do
    rel="${src#$DOT_ROOT/$m/}"
    tgt="$HOME/$rel"
    if [ -e "$tgt" ] || [ -L "$tgt" ]; then
      echo "  Removing $tgt"
      rm -rf "$tgt"
    fi
  done
done

# Stow modules into place
MODULES=(home zsh config iterm2 firefox)
# Stow modules into place, using restow to overwrite existing symlinks
for m in "${MODULES[@]}"; do
  TARGET="$HOME"
  case "$m" in
    iterm2) TARGET="$HOME/Library/Colors" ;;
    firefox) TARGET="$HOME" ;;
  esac
  echo "Restowing module '$m' into $TARGET"
  stow --dir="$DOT_ROOT" --target="$TARGET" --verbose --restow "$m"
done

# Install Tmux plugins
TPM_INSTALL_DIR=$HOME/.tmux/plugins/tpm
if [ ! -d "$TPM_INSTALL_DIR" ]; then
  echo "Installing tmux plugin manager 📺"
  git clone https://github.com/tmux-plugins/tpm $TPM_INSTALL_DIR
fi


# Setup oh-my-zsh and associated themes/fonts/plugins
# Setup oh-my-zsh (without modifying stub .zshrc)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh"
  git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
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


echo "🚀 REMEMBER TO: To complete powerlevel10k setup visit: https://github.com/romkatv/powerlevel10k 🐸"


# Homebrew update & upgrade (brew already installed at script start)
echo "Updating Homebrew and upgrading packages..."
$BREW_CMD update
$BREW_CMD upgrade

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

BREW_FILE="$DOT_ROOT/Brewfile"
if $BREW_CMD bundle check --file $BREW_FILE >/dev/null 2>&1; then
  echo "Brew bundle for common items up-to-date"
else
  echo "Launching Brew bundler for common items 🤖"
  $BREW_CMD bundle --file $BREW_FILE >/dev/null 2>&1
fi


# Pyenv should be installed by brew
if [ $SYS = $MAC ]; then
  echo "Installing python versions"
  # When prompted to re-install if already installed say no (N)
  # Some issues when installing python2 on linux, not needed for now
#  yes "N" | pyenv install 2
#  yes "N" | pyenv install 3
fi


# NPM should be installed by brew
echo "Installing npm stuff 🐶"
npm_global_install awsp # AWS profile switcher

# Install Node Version Manager
NVM_HOME_DIR=$HOME/.nvm
if [ ! -d "$NVM_HOME_DIR" ]; then
  echo "Installing Node Version Manager ☊"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
fi

echo "🚀 Firefox CSS has been stowed via the 'firefox' module into ~/.mozilla/firefox/chrome/userChrome.css"

echo "Personal DotFile configuration complete ✨"
