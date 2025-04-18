export TJL_COMMON_IMPORTED=1

# Preferred editor for local and remote sessions
export EDITOR=nvim

# Pyenv config (only if installed)
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
# Initialize pyenv (if installed)
if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Initialize asdf (if installed)
if command -v asdf >/dev/null 2>&1; then
  . "$(brew --prefix asdf)/libexec/asdf.sh"
fi

# Initialize direnv (if installed)
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git jenv)

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

# Oh My Zsh initialization
export ZSH=$HOME/.oh-my-zsh
if [ -f "$ZSH/oh-my-zsh.sh" ]; then
  source "$ZSH/oh-my-zsh.sh"
fi


## zplug plugin manager (if available)
if [ -n "$HOMEBREW_ROOT" ] && [ -f "$HOMEBREW_ROOT/opt/zplug/init.zsh" ]; then
  source "$HOMEBREW_ROOT/opt/zplug/init.zsh"
  # ZSH theme
  zplug romkatv/powerlevel10k, as:theme, depth:1
  # git+fzf utility
  zplug wfxr/forgit
  # CLI syntax highlighter
  zplug "zsh-users/zsh-syntax-highlighting", defer:2
  # Install plugins if there are plugins that have not been installed
  if ! zplug check --verbose; then
    printf "Install new plugins? [y/N]: "
    if read -q; then
      echo; zplug install
    fi
  fi
  zplug load
fi

# Oh-my-zsh Theme Settings
export CUSTOM_ZSH_THEMES=$MY_DOT_ROOT/zsh-themes
source $CUSTOM_ZSH_THEMES/current.sh

# NVM Configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

###########
# ALIASES #
###########

# Alias eza to a simple ls command
alias l='eza --icons --git -lag'

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


export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --no-ignore --exclude .git'

# Helpful options stolen from https://betterprogramming.pub/boost-your-command-line-productivity-with-fuzzy-finder-985aa162ba5d#d515
export FZF_DEFAULT_OPTS="
--layout=reverse
--info=inline
--height=80%
--multi
--preview-window=:hidden
--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
--color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'
--prompt='∼ ' --pointer='▶' --marker='✓'
--bind '?:toggle-preview'
--bind 'ctrl-e:execute(nvim {} < /dev/tty > /dev/tty)'
--bind 'ctrl-b:preview-page-up,ctrl-f:preview-page-down,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down'
"

# Simple searching with FZF via CTRL-T
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Deal with Mac so we can use FZF's ALT-C behavior
bindkey "ç" fzf-cd-widget
export FZF_ALT_C_COMMAND='fd --type d --strip-cwd-prefix --hidden --follow --no-ignore --exclude .git'


# NOTE: This needs to be included at the end of the file due to other includes 
# potentially overwriting the auto-completion shortcuts.

# Setup fzf key bindings and auto completions
export PATH="${PATH:+${PATH}:}$HOMEBREW_ROOT/opt/fzf/bin"

# Auto-completion
source "$HOMEBREW_ROOT/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
source "$HOMEBREW_ROOT/opt/fzf/shell/key-bindings.zsh"
