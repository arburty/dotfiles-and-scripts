" remove_whitespace.vim
"
" Remove extra whitespace in java files.
"
" Trying to use vim.cmd [[]] did not work for some reason.
" Also putting it in a file ftplugin/java.vim did not work.
" So here we are, autocmds, for a filetype, as a plugin!

augroup remove_extra_whitespace_java
  autocmd!
  autocmd FileType java autocmd BufWritePre <buffer> call RemoveWhitespaceJava()
augroup end

" cases are:
"   1. Remove trailing spaces 
"   2. All empty lines before a closeing brace
"   3. Leave one whitespace if followed by anything else
"   4. Remove blank lines after an opening brace
"   5. Remove blank trailing lines in the file.
func! RemoveWhitespaceJava() abort
  let cur = getpos(".")
  let save_search = @/

  sil! %s/\s\+$//e
  sil! %s/\v\zs(^$\n)+\ze\s*\}//e
  sil! %s/\v\zs(^$\n){2,}\ze\s*[^}]//e
  sil! %s/\v\{\n\zs(^$\n)+\ze//e
  sil! %s#\($\n\s*\)\+\%$##e

  call setpos('.', cur)
  let @/=save_search
endfunc
