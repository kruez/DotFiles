# Define env var to uniquely signify this file has been loaded
export TJL_MAC_IMPORTED=1 

# Use ZSH expansion to get current file
CUR_FILE="${(%):-%N}"

# Get actual current location of file if symlink
if [ -L "$CUR_FILE" ]
then
  CUR_FILE=$(readlink $CUR_FILE)
fi

# Make sure brew installed binaries found before system provided ones
export PATH="/opt/homebrew/bin:$PATH"

# Get current file, follow the symlink, and get the root dir
MY_DOT_ROOT=$(dirname "$CUR_FILE")

source $MY_DOT_ROOT/common.sh

# Alias exa to a simple command
alias l='exa --icons --git -lFg'

# Prefer bat over built-in cat
alias cat='bat'

# Easily open text files in the console app
alias console='open -a "Console"'

# Open a file in MacVim from the terminal
function mvim { /Applications/MacVim.app/Contents/MacOS/Vim -g $*; }

# Select and copy text from Apple Preview
defaults write com.apple.finder QLEnableTextSelection -bool true

# Configure fancy git diffing
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global interactive.diffFilter "diff-so-fancy --patch"

# CUSTOM FUNCTIONS
dif () { diff -u $1 $2 | diff-so-fancy; }
