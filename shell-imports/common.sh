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

# Print disk usage of current directory and sort it
# TODO Make this work on OSX, only works on Linux right now
alias duc='du -h --max-depth=1 | sort -h'

# Git aliases
alias st='git st'
alias sshow='git sshow'
alias sapply='git sapply'

# Dynamically set some git config values
git config --global user.name "Tim Lawson"
git config --global user.email "timothy.lawson@gmail.com"

# Print out Powerlevel9K colorcodes with example text
alias colorcodes='for code ({000..255}) print -P -- "$code: %F{$code}This is how your text would look like%f"'

# Powerlevel9k Theme Settings
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status vcs time)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3

POWERLEVEL9K_DIR_HOME_BACKGROUND='111'
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='111'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='111'
POWERLEVEL9K_DIR_HOME_FOREGROUND='232'
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='232'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='232'

POWERLEVEL9K_VCS_CLEAN_BACKGROUND='232'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='119'
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='232'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='214'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='232'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='196'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='232'
