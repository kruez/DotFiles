export TJL_COMMON_IMPORTED=1

# Preferred editor for local and remote sessions
export EDITOR=nvim

# Oh-my-zsh Theme Settings
export CUSTOM_ZSH_THEMES=$MY_DOT_ROOT/zsh-themes
source $CUSTOM_ZSH_THEMES/current.sh

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# REMEMBER: zsh-syntax-highlighting MUST be last
plugins=(git zsh-syntax-highlighting)

# Display red dots whilst waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
#ALIEN_ZSH=~/.oh-my-zsh/custom/themes/alien/alien.zsh
#[[ ! -f $ALIEN_ZSH ]] || source $ALIEN_ZSH

###########
# ALIASES #
###########

# Alias exa to a simple ls command
alias l='exa --icons --git -laFg'

# Simple file explorer. The leading . causes ranger to exit to the current selected dir
alias r='. ranger'

# Prefer neovim if available
alias v='nvim'

# Prefer bat over built-in cat
alias cat='bat'

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
alias gpr='git pull --rebase'
alias sshow='git sshow'
alias sapply='git sapply'

# Dynamically set some git config values
git config --global user.name "Tim Lawson"
git config --global user.email "timothy.lawson@gmail.com"

# Print out Powerlevel10K colorcodes with example text
alias colorcodes='for code ({000..255}) print -P -- "$code: %F{$code}This is how your text would look like%f"'

alias p10update='git -C ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k pull'

# AWS profile switcher shortcut installed via npm
alias awsp="source _awsp"


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

####################
# CUSTOM FUNCTIONS #
####################

dif () { diff -u $1 $2 | diff-so-fancy; }

#######
# FZF #
#######

# NOTE: This needs to be included at the end of the file due to other includes 
# potentially overwriting the auto-completion shortcuts.

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'

# Setup fzf key bindings and auto completions
export PATH="${PATH:+${PATH}:}$HOMEBREW_ROOT/opt/fzf/bin"

# Auto-completion
source "$HOMEBREW_ROOT/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
source "$HOMEBREW_ROOT/opt/fzf/shell/key-bindings.zsh"
