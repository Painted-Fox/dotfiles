call plug#begin()

" Look and feel --------------------------------------------------------------

" Defaults everyone can agree on
Plug 'tpope/vim-sensible'
" Surround text with parentheses, brackets, quotes, XML tags, and more
Plug 'tpope/vim-surround'
" lean & mean status/tabline for vim that's light as air
Plug 'bling/vim-airline'
" Simple tmux statusline generator
Plug 'edkolev/tmuxline.vim'
" A dark color scheme for Vim & gVim
Plug 'w0ng/vim-hybrid'

" Writing tools --------------------------------------------------------------

" Distraction-free writing in Vim
Plug 'junegunn/goyo.vim'
" Rethinking Vim as a tool for writing
Plug 'reedes/vim-pencil'


" Coding tools ---------------------------------------------------------------

" EditorConfig plugin for Vim
Plug 'editorconfig/editorconfig-vim'
" fugitive.vim: a Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" Language specific ----------------------------------------------------------

" Vim support for editing fish scripts
Plug 'dag/vim-fish'
" Mustache and Handlebars mode for vim
Plug 'mustache/vim-mustache-handlebars'

call plug#end()
