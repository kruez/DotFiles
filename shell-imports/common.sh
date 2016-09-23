# Define env var to uniquely signify this file has been loaded
export TJL_COMMON_IMPORTED=1

# Preferred editor for local and remote sessions
export EDITOR='vim'

# Use vim keybindings on CLI
bindkey -v

# Add some overrides to use with vim keybindings
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
export KEYTIMEOUT=1

# Aliases

# List open ports
alias ports='sudo lsof -i'

# Search for a specific port
alias port='sudo lsof -i | grep '

