" Hard wrap the current paragraph.  Similar to emacs and Sublime Text.
nmap <Leader>q gqip

" ==== NERD tree
" toggle with <Leader> + e
nmap <Leader>e :NERDTreeToggle<CR>

" ==== Goyo
" toggle with <Leader> + spacebar
nnoremap <Leader><Space> :Goyo<CR>

" ==== Ag
" Open the Ag command and place the cursor into the quotes
nmap <Leader>ag :Ag ""<Left>
nmap <Leader>af :AgFile ""<Left>

" Protection against accidental F1 key.
noremap <F1> <Esc>

" Protect against accidental ; key. This does remove some functionality.
" See: http://vim.wikia.com/wiki/Map_semicolon_to_colon
nnoremap ; :

" i always, ALWAYS hit ":W" instead of ":w"
command! Q q
command! W w