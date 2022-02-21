" QuickfixToggle {{2

nnoremap <leader>Q :call <SID>QuickfixToggle()<cr>
let s:quickfix_is_open = 0
function! s:QuickfixToggle()
  if s:quickfix_is_open
    cclose
    let s:quickfix_is_open = 0
    execute s:quickfix_return_to_window . "wincmd w"
  else
    let s:quickfix_return_to_window = winnr()
    copen
    let s:quickfix_is_open = 1
  endif
endfunction
" }}2
