# kruez DotFiles

Modular, Stow-based management of personal dotfiles for home and work environments.

## Quickstart

Clone the repository and bootstrap:
```bash
# Clone into your workspace (adjust path as desired):
git clone <repo-url> ~/Workspace/DotFiles
cd ~/Workspace/DotFiles
# For personal (home) or work setup:
./install.sh home   # or 'work'
```

## Automated Testing of install.sh

Validate your installer in isolation:

- **Container mode** (Ubuntu 22.04): requires Docker or Podman (auto-installs Podman if missing):
  ```bash
  scripts/test-install.sh
  ```
- **Local sandbox mode** (macOS/Linux host): runs installer against a temp $HOME:
  ```bash
  scripts/test-install.sh --local
  ```

Inspect the output; local mode prints the temporary HOME path for review.

## Modules Layout

Each top-level directory is a Stow module mapping into your home directory:
```bash
.
├── Brewfile
├── install.sh
├── scripts/
│   └── test-install.sh
├── bin/            # custom scripts → ~/bin
├── home/           # dotfiles → ~/.(gitconfig|vimrc|tmux.conf|...)
├── config/         # ~/.config/ (nvim, ranger)
├── iterm2/         # ~/Library/Colors/*.itermcolors
├── firefox/        # ~/.mozilla/firefox/chrome/userChrome.css
└── zsh/            # ~/.zshrc + ~/.zsh/
```

## Managing Modules

Restow an individual module without the full installer:
```bash
DOTFILES_DIR=~/Workspace/DotFiles
stow --dir="$DOTFILES_DIR" --target="$HOME" --restow zsh
```

## Customizations

### Shell & Prompt
- Zsh with [Oh My Zsh](https://ohmyzsh.com/) and Powerlevel10k theme
- Plugins managed via [zplug](https://github.com/zplug/zplug): git, jenv, forgit, zsh-syntax-highlighting

### Aliases
- `l` → `eza --icons --git -lag`
- `r` → `ranger`
- `v` → `nvim`
- `cat` → `bat`
- `ports` / `port` → `lsof -i`
- `reload` → `source ~/.zshrc`
- `duc` → `du -h --max-depth=1 | sort -h`
- Git: `st`, `gpr`, `sshow`, `sapply`
- `colorcodes` → display 256-color palette
- `p10update` → update Powerlevel10k
- `awsp` → AWS profile switcher

### Functions
- `homebrew_root()` → returns Homebrew install prefix
- `npm_global_install <pkg>` → idempotent npm global install
- `dif file1 file2` → pretty diff via diff-so-fancy

### FZF
- Uses `fd` under the hood: `--type f --hidden --follow --exclude .git`
- Keybindings: Ctrl-T (files), Ctrl-R (history), Alt-C (cd)
- Inline previews, layout, and color via `$FZF_DEFAULT_OPTS`

### Ranger
- Custom `rc.conf` and Gruvbox colorscheme under `config/ranger`

### Neovim
- `init.vim` located in `config/nvim`

### iTerm2
- Gruvbox & Monokai `.itermcolors` under `iterm2/Library/Colors`

### Firefox
- `userChrome.css` for toolbar & tab theming in `firefox/.mozilla/firefox/chrome`

## Contributing

Feedback, bug reports, and PRs are welcome to improve and expand these dotfiles.