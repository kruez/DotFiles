# asdf Cheatsheet

The asdf version manager lets you manage multiple runtime versions under one roof.

## Plugin Management
- `asdf plugin add <name> <git-url>`   → Add a plugin
- `asdf plugin list`                   → List installed plugins
- `asdf plugin remove <name>`          → Remove a plugin

## Install & List Versions
- `asdf list all <name>`               → Show all available versions
- `asdf install <name> <version>`      → Install a specific version
- `asdf list <name>`                   → Show installed versions

## Set Versions
- `asdf global <name> <version>`       → Set global default
- `asdf local <name> <version>`        → Set version for current directory
- `asdf current`                       → Display current versions for all tools

## Shims & Binary Lookup
- `asdf which <binary>`                → Show full path to shim