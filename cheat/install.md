# DotFiles Install Cheatsheet

Use `install.sh` to bootstrap your environment with your personal dotfiles and tools.

## Usage
```bash
./install.sh <mode>
```

### Modes
- `home` : Personal dotfile configuration.
- `work` : Work-specific configuration.

## Quickstart
1. Clone this repo.
2. Ensure prerequisites: Git, curl, Zsh.
3. Run:
   ```bash
   ./install.sh home
   ```

## What It Does
- Installs Homebrew (if missing).
- Installs GNU Stow and stows modules: `home`, `zsh`, `config`, `iterm2`, `firefox`.
- Installs Tmux Plugin Manager (TPM).
- Installs Oh My Zsh.
- Installs MesloLGS Nerd Fonts.
- Updates Homebrew and applies `Brewfile` via `brew bundle`.
- Installs global npm packages (e.g., `awsp`).
- Installs Node Version Manager (nvm).

🚀 Remember: After install, visit https://github.com/romkatv/powerlevel10k for Powerlevel10k setup.