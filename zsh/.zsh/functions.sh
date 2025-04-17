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

# -----------------------------------------------------------------------------
# Auto correction via thefuck (install via `brew install thefuck`)
if command -v thefuck >/dev/null 2>&1; then
  eval "$(thefuck --alias)"
fi

# AI-powered shell helper (install OpenAI CLI via `brew install openai` and set OPENAI_API_KEY)
if command -v openai >/dev/null 2>&1 && command -v jq >/dev/null 2>&1; then
  # one-shot AI translator function
  ai() {
    openai api chat.completions.create \
      -m gpt-3.5-turbo \
      -p "Translate to bash: $*" \
      --stream \
    | jq -r '.choices[].delta.content'
  }
  alias ask=ai
  # zle widget: type description and press Ctrl-X g to replace buffer with AI-generated command
  ai_widget() {
    local cmd
    cmd=$(openai api chat.completions.create \
      -m gpt-3.5-turbo \
      -p "Translate to bash: $BUFFER" \
      | jq -r '.choices[0].message.content')
    if [[ -n $cmd ]]; then
      BUFFER="$cmd"
      zle accept-line
    fi
  }
  zle -N ai_widget
  bindkey '^Xg' ai_widget
fi

# -----------------------------------------------------------------------------
# Unified fix function: try thefuck first, then AI, else report no suggestion
fix() {
  # Attempt local autocorrect via thefuck alias
  if command -v fuck >/dev/null 2>&1; then
    # --yes runs the suggested fix automatically
    if fuck --yes 2>/dev/null; then
      return 0
    fi
  fi

  # Fallback: ask AI to translate last command
  if command -v openai >/dev/null 2>&1 && command -v jq >/dev/null 2>&1; then
    # Capture the previous command
    local last_cmd
    last_cmd=$(fc -ln -1)
    echo "AI suggestion for: $last_cmd"
    local suggestion
    suggestion=$(openai api chat.completions.create \
      -m gpt-3.5-turbo \
      -p "Translate to bash: $last_cmd" \
      | jq -r '.choices[0].message.content')
    if [[ -n $suggestion ]]; then
      echo "+ $suggestion"
      eval "$suggestion"
      return 0
    fi
  fi

  echo "No suggestions available from thefuck or AI."
  return 1
}
alias fix=fix
alias fixit=fix
