" OpenURLUnderCursor()
" Open URL's workaround
function! OpenURLUnderCursor()
  let s:uri = expand('<cWORD>')
  let s:uri = substitute(s:uri, '.*[^\\][<(]', '', '')
  let s:uri = substitute(s:uri, '[)]$', '', '')
  let s:uri = substitute(s:uri, '[\\][(]', '(', '')
  let s:uri = substitute(s:uri, '[\\][)]', ')', '')

  " let s:uri = substitute(s:uri, '?', '\\?', '')
  let s:uri = shellescape(s:uri, 1)
  echom s:uri
  if s:uri != ''
    sil exec "!".s:browser." ".s:uri." >/dev/null 2>&1"
    :redraw!
  endif
endfunction

let s:browser = $localmachine == "WSL" ? "msedge.exe" : "gio open"
let g:netrw_browsex_viewer = s:browser
nnoremap gx :call OpenURLUnderCursor()<CR>
