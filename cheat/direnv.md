# direnv Cheatsheet

Direnv enables project-specific environment variables via `.envrc` files.

## Setup
- Add to shell init: `eval "$(direnv hook zsh)"`

## Usage
- Create an `.envrc` in project root with `export VAR=value` lines.
- `direnv allow`   → Approve the `.envrc` to load its settings
- `direnv deny`    → Disallow `.envrc` and unload settings
- `direnv reload`  → Re-evaluate the current `.envrc`

## Handy Tips
- To see what direnv will do: `direnv diff`
- To list loaded environments: `direnv status`