" Make it beautiful - colors and fonts

if has("gui_running")
  "tell the term has 256 colors
  set t_Co=256

  " Show tab number (useful for Cmd-1, Cmd-2.. mapping)
  " For some reason this doesn't work as a regular set command,
  " (the numbers don't show up) so I made it a VimEnter event
  autocmd VimEnter * set guitablabel=%N:\ %t\ %M

  set lines=60
  set columns=190

  if has("gui_win32")
    set guifont=Source_Code_Pro:h14,Consolas:h14
  else
    set guifont=Source\ Code\ Pro\ Medium\ 14,DejaVu\ Sans\ Mono\ 14
  endif

  " Call this later or the columns variable won't reflect the final value.
  autocmd VimEnter * call s:AdjustFontSize()
else
  "dont load csapprox if we no gui support - silences an annoying warning
  let g:CSApprox_loaded = 1
  let g:solarized_termcolors=256
  let g:solarized_termtrans=1
endif

" http://ethanschoonover.com/solarized/vim-colors-solarized
colorscheme solarized
set background=dark

" Decrease fontsize if we have a smaller screen.
function! s:AdjustFontSize()
  if &columns < 190
    let l:fsize = substitute(&guifont, '^.*:h\([^:,]*\).*$', '\1', '')
    let l:fsize -= 2
    let l:guifont = substitute(&guifont, ':h\([^:,]*\)', ':h' . l:fsize, 'g')
    let &guifont = l:guifont
  endif
endfunction

