# Define env var to uniquely signify this file has been loaded
export TJL_LINUX_IMPORTED=1

# Use ZSH expansion to get current file
CUR_FILE="${(%):-%N}"

# Get actual current location of file if symlink
if [ -L "$CUR_FILE" ]
then
  CUR_FILE=$(readlink $CUR_FILE)
fi

export HOMEBREW_ROOT="/home/linuxbrew/.linuxbrew"

# Make sure brew installed binaries found before system provided one
export PATH="$HOMEBREW_ROOT/bin:$HOMEBREW_ROOT/sbin:$PATH"

# Get current file, follow the symlink, and get the root dir
MY_DOT_ROOT=$(dirname "$CUR_FILE")

source $MY_DOT_ROOT/common.sh
