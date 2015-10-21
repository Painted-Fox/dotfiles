" Airline --------------------------------------------------------------------

let g:airline_powerline_fonts = 1
let g:airline_theme = 'hybridline'
" Disable airline-tmuxline so it doesn't overwrite the theme.
let g:airline#extensions#tmuxline#enabled = 0
" Enable tabline
let g:airline#extensions#tabline#enabled = 1


" Goyo -----------------------------------------------------------------------

let g:goyo_width = 80 " Set goyo's width


" Goyo Mappings --------------------------------------------------------------

" Toggle distraction-free mode
nnoremap <leader>w :Goyo<CR>


" Pencil ---------------------------------------------------------------------

let g:pencil#textwidth = 80             " Set pencil's width
let g:pencil#wrapModeDefault = 'soft'   " Use soft wrap
let g:pencil#joinspaces = 1             " Use two spaces after a period
augroup pencil
    autocmd!
    autocmd FileType markdown call pencil#init()
augroup END


" Hybrid Colorscheme ---------------------------------------------------------

let g:hybrid_use_Xresources = 1
if !empty(glob("~/.vim/plugged/vim-hybrid"))
    set background=dark
    colorscheme hybrid
endif


" EditorConfig ---------------------------------------------------------------

" Ensure that EditorConfig plays wiell with Tim Pope's fugitive.
let g:EditorConfig_exclude_patterns = ['fugitive://.*']


" Fugitive Mappings ----------------------------------------------------------
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gs :Gstatus<CR>
