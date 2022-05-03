" OpenURLUnderCursor()
" Open URL's workaround
function! OpenURLUnderCursor()
  let s:uri = expand('<cWORD>')
  let s:uri = substitute(s:uri, '?', '\\?', '')
  let s:uri = shellescape(s:uri, 1)
  if s:uri != ''
    silent exec "!gio open '".s:uri."' >/dev/null 2>&1"
    :redraw!
  endif
endfunction

let g:netrw_browsex_viewer= "gio open"
nnoremap gx :call OpenURLUnderCursor()<CR>
