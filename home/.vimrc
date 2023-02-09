set nocompatible  " This must be first, because it changes other options as side effect

syntax on

set relativenumber  " show relative line numbers
set number          " show current line number

set expandtab      " tabs are spaces
set tabstop=4      " number of visual spaces per TAB
set softtabstop=4  " number of spaces in tab when editing
set shiftwidth=4   " number of spaces intended with the reindent operations

set autoindent  " maintain indentation when inserting a newline

" Toggle Nerd Tree display Ctrl+n
map <C-n> :NERDTreeToggle<CR>

" Word Processor Mode - for editing plain english
func! WordProcessorMode()
  setlocal textwidth=80
  setlocal smartindent
  setlocal spell spelllang=en_us
  setlocal noexpandtab
endfu

" Enable Word Processor Mode with :WP
com! WP call WordProcessorMode()

" Set this since term supports truecolor
set termguicolors

" Setup custom colorscheme
set runtimepath+=~/.vimstyles
let java_comment_strings=1
let java_highlight_functions=1
let java_highlight_java_lang_ids=1
let java_space_errors=1
let java_highlight_debug=1
let java_mark_braces_in_parens_as_errors=1
syntax on
colorscheme kruez-monokai


" PLUG-INS

" Auto Install Plug-in Manager if not present
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif


" Setup Plug-ins
call plug#begin('~/.vim/plugged')
" Make sure you use single quotes

" Enable fzf in vim
Plug 'junegunn/fzf'

Plug 'tpope/vim-sensible'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Add plugins to &runtimepath
call plug#end()