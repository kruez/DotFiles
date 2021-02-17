# Preferred editor for local and remote sessions
export EDITOR='vim'

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

# Print out Powerlevel10K colorcodes with example text
alias colorcodes='for code ({000..255}) print -P -- "$code: %F{$code}This is how your text would look like%f"'

alias p10update='git -C ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k pull'

export ZSH=$HOME/.oh-my-zsh

# Oh-my-zsh Theme Settings
ZSH_THEME="powerlevel10k/powerlevel10k"

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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

