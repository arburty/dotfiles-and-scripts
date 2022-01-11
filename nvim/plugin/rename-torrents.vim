" rename-torrents.vim
" Author : Austin Burt
" Email  : austin@burt.us.com
" Date   : 12/15/21
"
" Recreation of a once great script before the great
" data loss of 2021

" Mappings
nnoremap <leader>py :RenameFromClipboard<cr>

" Functions
func! s:renameFromClipboard() abort
    echom "here in rename-torrents.vim"
    let dashorcolon="(([:-]\\d{2}){3}\\.\\d{3}_.*\\.jpg|\\.(mkv|mp4|webm))"
    let dateswdots="-(\\d{2}\\.){2}\\d{2}-\\d{3}\\.jpg"
    let verymagicbeginning="\\v^\\&?\\zs.*\\ze"
    let pattern=verymagicbeginning."(".dashorcolon."|".dateswdots.")"."$"
    let fromclip=@+
                                            "00 . 00 . 00(00)
    let fromclip=substitute(fromclip, "\\s\\?\\(\\d\\{2}\\.\\)\\{2}\\d\\{2,4}\\s\\?", "", "")
    let fromclip=substitute(fromclip, "\\s\\?\\d\\{2,4}p$", "", "")
    let fromclip=substitute(fromclip, "\\s*$", "", "")

    exec "sil %s/".pattern."/".fromclip."/"
endfunc

" Commands
command! RenameFromClipboard :call <SID>renameFromClipboard()
