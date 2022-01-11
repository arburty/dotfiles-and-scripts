" wsl_clip.vim

echom "Here in wsl_clip!!!"
" Tmux clipping
vnoremap <leader>y "zy:<c-u>SaveSelection<cr>
nnoremap <leader>y :<c-u>SaveSelection<cr>
nnoremap <leader>Y :let @z=@" <bar> SaveSelection<cr>

command! SaveSelection call <SID>SaveSelectionToTmuxAndClip()

" SaveSelectionToFileAndTmuxClip {{2
" used to sync vim on wsl to the clipboard
function! s:SaveSelectionToTmuxAndClip()
  silent! exe "!( ~/bin/saveArgsToTmuxAndClip.sh " . trim(shellescape(getreg('z'), 1)). " &)"
  " redraw!
endfunction

echom "Finished wsl_clip!!!"
