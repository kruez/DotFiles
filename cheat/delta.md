# Delta Cheatsheet

Delta provides syntax-highlighted, side-by-side diffs for Git and piping.

## Usage
- `delta file1 file2`                  → Diff two files
- `git diff | delta`                   → Pipe Git diff through delta
- `gitd` (alias)                       → `git diff | delta`

## Configuration
- User config in `~/.gitconfig`: add under `[delta]` section
  ```ini
  [delta]
    side-by-side=true
    width = 80
    syntax-theme = Dracula
    file-style = normal
  ```

## Key Bindings
- Enter                       → expand/unexpand diff hunk
- n / N                       → next/previous diff hunk