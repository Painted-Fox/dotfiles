call pathogen#infect()
syntax on
filetype plugin indent on

" Powerline status line
set nocompatible   " Disable vi-compatibility
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show unicode glyphs

" Show line numbers
set number

" Solarized
set background=dark
colorscheme solarized

" Use Consolas on Windows and Inconsolata everywhere else
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_win32")
    set guifont=Consolas:h11
    set guifontwide=MingLiU:h11 "For windows to display mixed character sets
  endif
endif