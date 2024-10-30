" sprint_finder.vim
" Author : Austin Burt
" Email  : austin@burt.us.com
" Date   : 02/28/22
"
" Populate the quickfix menu with the story_notes for a given sprint.

func! s:sprintFinder(sprintnum) abort
  exe "vimgrep \"^S" . a:sprintnum . "\\(: [a-zA-Z]\\{3} \\d\\d\\?\\)\\?$\" ~/story_notes/**/*.{md,snote}"
endfunc

command! -nargs=1 Sprint :call <SID>sprintFinder(<args>)

nnoremap <leader>sp :Sprint<space>
