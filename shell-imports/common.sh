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

# Overwrite right side prompt with vi mode
#function zle-line-init zle-keymap-select {
#    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
#    RPS2=$RPS1
#    zle reset-prompt
#}
# Bind vi-mode prompt update to zsh events
# zle -N zle-line-init
# zle -N zle-keymap-select

# Aliases

# List open ports
alias ports='sudo lsof -i'

# Search for a specific port
alias port='sudo lsof -i | grep '

# Reload zshrc
alias reload='source ~/.zshrc'

# Dynamically set some git config values
git config --global user.name "Tim Lawson"
git config --global user.email "timothy.lawson@gmail.com"

# Powerlevel9k Theme Settings
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon context time vi_mode dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status vcs ip battery)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
