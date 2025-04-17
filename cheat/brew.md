# Homebrew Cheatsheet

This DotFiles uses Homebrew to manage packages and a Brewfile to declare common items.

## Homebrew Installation

Non-interactive:
  ```bash
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

## Basic Commands

- `brew update`                  → Update Homebrew.
- `brew upgrade`                 → Upgrade installed formulae.
- `brew install <package>`       → Install a package.
- `brew list`                    → List installed packages.
- `brew uninstall <package>`     → Uninstall a package.

## Brewfile

- Path: `Brewfile` in repository root.
- `brew bundle --file Brewfile`       → Install all items in Brewfile.
- `brew bundle check --file Brewfile` → Verify items are installed.