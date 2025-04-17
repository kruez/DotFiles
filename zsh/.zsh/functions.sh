# Get the current root of homebrew
homebrew_root() {
  if [ `uname` = "Darwin" ]; then
    echo "/opt/homebrew"
  else
    echo "/home/linuxbrew/.linuxbrew"
  fi
}

# Install the specified npm globally, but skipping the install if it's already installed
npm_global_install() {
  local npm_cmd="$(homebrew_root)/bin/npm"
  if ! $npm_cmd list -g "$1" 2>&1 >/dev/null; then
      $npm_cmd install "$1" -g
  else
      echo "$1 already installed"
  fi
}

# Cheat sheet helper
cheat() {
  # If no topic is given, list all available local cheat sheets
  if [[ $# -eq 0 ]]; then
    echo "Available local cheat topics:"
    for cheatfile in "$DOTFILES_ROOT/cheat"/*.md; do
      echo "  - $(basename "${cheatfile%.md}")"
    done
    echo
    echo "For community cheats, try:"
    echo "  curl https://cheat.sh/<topic>"
    echo "  tldr <topic>  # install via 'brew install tldr'"
    return 0
  fi
  local topic=$1
  local file="$DOTFILES_ROOT/cheat/$topic.md"
  if [[ -f "$file" ]]; then
    bat --style=numbers --pager=less "$file"
  else
    echo "No local cheat sheet for '$topic'."
    echo "Fetching from cheat.sh..."
    # Display remote cheat.sh result with ANSI colors
    curl -s "https://cheat.sh/${topic}" | less -R
    echo
    echo "Tip: install 'tldr' for concise TL;DR pages: tldr $topic"
    return 0
  fi
}

# Shortcut alias for cheatsheets
alias cs='cheat'
alias cheats='cheat'

# Use delta for diff if available
if command -v delta >/dev/null 2>&1; then
  alias diff='delta'
  alias gitd='git diff | delta'
fi
