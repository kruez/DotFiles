# Vim Cheatsheet

Custom Vim settings are defined in `~/.vimrc` and shared with Neovim.

## Basic Settings
- `syntax on`, `termguicolors`.
- `relativenumber` & `number`.
- `expandtab`, `tabstop=4`, `shiftwidth=4`, `autoindent`.
- `hidden` → Allow buffer switching without saving.

## Editor & Grep
- `EDITOR=nvim`.
- `grepprg=rg --vimgrep --smart-case --follow`.

## Leader Key
- `let mapleader = ","`.

## Toggling & Shortcuts
- `<C-n>` → `:NERDTreeToggle` (toggle file explorer).

## FZF Bindings
- `,b` → `:Buffers`  
- `<C-f>` → `:Files`  
- `,f` → `:Rg`  
- `,/` → `:BLines`  
- `,'` → `:Marks`  
- `,g` → `:Commits`  
- `,H` → `:Helptags`  
- `,hh` → `:History`  
- `,h:` → `:History:`  
- `,h/` → `:History/`

## Word Processor Mode
- `:WP` → Sets `textwidth=80`, `spell`, `noexpandtab`, `smartindent`.

## Colorscheme & Plugins
- `colorscheme kruez-monokai` (from `~/.vimstyles`).
- Vim-plug auto-installs if missing.
- Plugins:
  - `junegunn/fzf`, `junegunn/fzf.vim`
  - `tpope/vim-sensible`
  - `scrooloose/nerdtree` (on demand)
  - `frazrepo/vim-rainbow`