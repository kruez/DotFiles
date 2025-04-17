# Zsh Cheatsheet

Zsh configuration is stowed to `~/.zshrc` and the `~/.zsh/` directory.

## Entry Points
- `~/.zshrc`: Loads `functions.sh` and OS-specific config.
- `~/.zsh/functions.sh`: Common functions and aliases.
- `~/.zsh/common.sh`: Initializes pyenv, asdf, direnv, oh-my-zsh, zplug, FZF integration.

## Key Functions
- `homebrew_root()` → Prints Homebrew prefix.
- `npm_global_install <pkg>` → Installs npm package globally if missing.
- `cheat <topic>` → Show cheat sheets (`alias cs`/`cheats`).
- `dif <file1> <file2>` → Diff with `diff-so-fancy`.

## Aliases
See `cheat aliases` for a full list (e.g., `l`, `r`, `v`, `st`, `gpr`, `awsp`).

## Environment & Tools
- `EDITOR=nvim`.
- Pyenv, asdf, direnv auto-initialized if installed.
- NVM loaded from `~/.nvm`.
- Oh My Zsh loaded with `plugins=(git jenv)`.

## FZF Integration
- `FZF_DEFAULT_COMMAND`: `fd --type f --hidden --follow`.
- `FZF_DEFAULT_OPTS`: Preview, layout, colors.
- Bindings:
  - `Ctrl-T`: File finder.
  - `Alt-C`: Directory changer.
  - `Ctrl-E`: Open preview in editor.

## Keybindings & Completion
- `bindkey -v` → Vim keybindings in shell.
- History search: `Ctrl-r`.
- Arrow keys / `Ctrl-p`/`Ctrl-n` for history navigation.