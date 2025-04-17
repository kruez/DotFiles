# FZF Cheatsheet

## File & Directory Search

- `CTRL-T`  → Launch FZF to select files or directories
- `CTRL-R`  → Launch FZF to search command history
- `ALT-C`   → Launch FZF to cd into selected directory

## Preview & Layout

- `?:toggle-preview`             → Show/hide preview window
- `CTRL-P` / `CTRL-N`             → Navigate up/down in the list
- `CTRL-E`                        → Open selected file in \$EDITOR (nvim)

## Custom Options

- Uses `fd` under the hood with options: `--type f --hidden --follow --exclude .git`
- Preview command: `bat --style=numbers --color=always {}` for files