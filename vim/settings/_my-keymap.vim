" ==== NERD tree
" toggle with <Leader> + e
nmap <Leader>e :NERDTreeTabsToggle<CR>

" ==== Goyo
" toggle with <Leader> + spacebar
nnoremap <Leader><Space> :Goyo<CR>

" === Unite
" Search buffers with <Leader> + b
nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec<cr>
nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
nnoremap <Leader>b :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>

" ==== LanguageTool
nnoremap <Leader>l :LanguageToolCheck<CR>
nnoremap <Leader>L :LanguageToolClear<CR>

" ==== Navigation
" Nav between open buffers.
map <C-n> :bnext<CR>
map <C-p> :bprev<CR>

" Easier window nav.
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Easier tab nav.
map <S-j> :tabprevious<return>
map <S-k> :tabnext<return>

" ==== Util
" Toggle spellcheck.
nmap <Leader>s :setlocal invspell<CR>

" Hard wrap the current paragraph.  Similar to emacs and Sublime Text.
nmap <Leader>q gqip

" ==== Protect from Mistakes
" Protection against accidental F1 key.
noremap <F1> <Esc>

" Protect against accidental ; key. This does remove some functionality.
" See: http://vim.wikia.com/wiki/Map_semicolon_to_colon
nnoremap ; :

" Protect against accidental W or Q command from holding shift key.
command! Q q
command! W w
