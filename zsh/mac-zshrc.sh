# Define env var to uniquely signify this file has been loaded
export TJL_MAC_IMPORTED=1 

# Use ZSH expansion to get current file
CUR_FILE="${(%):-%N}"

# Get actual current location of file if symlink
if [ -L "$CUR_FILE" ]
then
  CUR_FILE=$(readlink $CUR_FILE)
fi

export HOMEBREW_ROOT="/opt/homebrew"

# Make sure brew installed binaries found before system provided ones
export PATH="$HOMEBREW_ROOT/bin:$PATH"

# Get current file, follow the symlink, and get the root dir
export MY_DOT_ROOT=$(dirname "$CUR_FILE")

source $MY_DOT_ROOT/common.sh

# Easily open text files in the console app
alias console='open -a "Console"'

# Open a file in MacVim from the terminal
function mvim { /Applications/MacVim.app/Contents/MacOS/Vim -g $*; }

# Select and copy text from Apple Preview
defaults write com.apple.finder QLEnableTextSelection -bool true

