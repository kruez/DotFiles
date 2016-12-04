syntax on

set relativenumber " show relative line numbers
set number         " show current line number

set expandtab     " tabs are spaces
set tabstop=4     " number of visual spaces per TAB
set softtabstop=4 " number of spaces in tab when editing
set shiftwidth=4  " number of spaces intended with the reindent operations

set autoindent " maintain indentation when inserting a newline

" Word Processor Mode - for editing plain english
func! WordProcessorMode()
  setlocal textwidth=80
  setlocal smartindent
  setlocal spell spelllang=en_us
  setlocal noexpandtab
endfu

" Enable Word Processor Mode with :WP
com! WP call WordProcessorMode()

