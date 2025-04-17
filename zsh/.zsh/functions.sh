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
