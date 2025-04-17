# GNU Stow Cheatsheet

DotFiles are organized into modules and managed via GNU Stow for creating symlinks.

## Modules
- `home`: personal dotfiles (`~/.gitconfig`, `~/.vimrc`, `~/.tmux.conf`, etc.)
- `zsh`: Zsh config and functions (`~/.zshrc`, `~/.zsh/`)
- `config`: application config (`~/.config/nvim`, `~/.config/ranger`)
- `iterm2`: iTerm2 color schemes (`~/Library/Colors`)
- `firefox`: Firefox CSS (`~/.mozilla/firefox/chrome`)

## Commands
```bash
# Stow a module (create or update symlinks)
stow --dir="$DOT_ROOT" --target="$TARGET" --restow <module>
```

Where `<module>` is one of: `home`, `zsh`, `config`, `iterm2`, `firefox`.

### Examples
- Restow core dotfiles:
  ```bash
  stow --dir="$DOT_ROOT" --target="$HOME" --restow home
  stow --dir="$DOT_ROOT" --target="$HOME" --restow zsh
  stow --dir="$DOT_ROOT" --target="$HOME" --restow config
  ```
- Restow iTerm2 colors:
  ```bash
  stow --dir="$DOT_ROOT" --target="$HOME/Library/Colors" --restow iterm2
  ```