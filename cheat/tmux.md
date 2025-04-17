# Tmux Cheatsheet

Custom tmux configuration is provided in `~/.tmux.conf`.

## Prefix
- `Ctrl+Space` (instead of default `Ctrl+b`).

## Panes
- `|` → `split-window -h` (horizontal split).
- `-` → `split-window -v` (vertical split).

## Mouse Mode
- `set -g mouse on` → Enable mouse support for pane resizing and selection.

## Reload Configuration
- Prefix + `r` → `source-file ~/.tmux.conf`.

## Plugins (TPM)
- TPM installed at `~/.tmux/plugins/tpm`.
- Defined plugins:
  - `tmux-plugins/tpm`
  - `tmux-plugins/tmux-sensible`
  - `dracula/tmux`
- Prefix + `I` → Install plugins.
- Prefix + `U` → Update plugins.

## Dracula Theme Options
Configured in `~/.tmux.conf` (battery, CPU, RAM, separators, icons).