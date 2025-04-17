# chezmoi Cheatsheet

Chezmoi manages your dotfiles across machines with templates and encryption.

## Bootstrap & Sync
- `chezmoi init <repo-url>`      → Clone repo to local dotfiles and apply to home
- `chezmoi apply`               → Apply dotfile changes to home directory
- `chezmoi update`              → Pull changes from remote

## Managing Files
- `chezmoi add <file>`          → Track a new file
- `chezmoi edit <file>`         → Edit a source file under `~/.local/share/chezmoi`
- `chezmoi uninit <file>`       → Stop tracking a file

## Viewing & Diffing
- `chezmoi diff`                → Show differences between source and actual home
- `chezmoi diff <file>`         → Diff a specific file

## Encryption (secrets)
- `chezmoi encrypt <file>`      → Encrypt a secret file
- `chezmoi decrypt <file>`      → Decrypt a secret file