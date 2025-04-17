# Tmuxinator Cheatsheet

Tmuxinator manages named tmux session layouts via simple YAML configs.

## Project Commands
- `tmuxinator new <project>`       → Create a new project config skeleton
- `tmuxinator start <project>`     → Launch the named project session
- `tmuxinator stop <project>`      → Stop the session
- `tmuxinator delete <project>`    → Delete the project config

## Configuration File
- Located at `~/.tmuxinator/<project>.yml`
- Define `windows:` and `panes:` sections for your layout

## Commands vs. Sessions
- `tmuxinator list`                → List available projects
- `tmuxinator debug <project>`     → Show verbose logs when starting