# Use control+space for prefix
unbind-key C-b
set-option -g prefix C-Space
bind-key C-Space send-prefix

# split panes using | and -
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %

# Enable mouse mode (tmux 2.1 and above)
set -g mouse on

# Reload config file
bind r source-file ~/.tmux.conf

# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'dracula/tmux'

# Dracula theme options
# https://draculatheme.com/tmux
set -g @dracula-show-battery false
set -g @dracula-show-network false
set -g @dracula-show-weather false
set -g @dracula-show-fahrenheit false
set -g @dracula-cpu-usage true
set -g @dracula-ram-usage true
set -g @dracula-gpu-usage false

set -g @dracula-show-powerline true
set -g @dracula-show-left-sep 
set -g @dracula-show-right-sep 
set -g @dracula-military-time false
set -g @dracula-show-left-icon 💀
set -g @dracula-border-contrast true

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'