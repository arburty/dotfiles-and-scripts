" rename-torrents.vim
" Author : Austin Burt
" Email  : austin@burt.us.com
" Date   : 12/15/21
"
" Recreation of a once great script before the great
" data loss of 2021

" Mappings
nnoremap <leader>py :RenameFromClipboard<cr>
nnoremap <leader>pt :RenameTorrent<cr>

" Functions
func! s:renameFromClipboard() abort
    echom "Here in rename-torrents.vim#renameFromClipboard"
    let verymagicbeginning="\\v^\\&?\\zs.*\\ze"
    let dashorcolon="(([:-]\\d{2}){3}\\.\\d{3}_.*\\.jpg|\\.(mkv|mp4|webm|avi|nfo))"
    let dateswdots="-(\\d{2}\\.){2}\\d{2}-\\d{3}\\.jpg"
    let pattern=verymagicbeginning."(".dashorcolon."|".dateswdots.")"."$"
    let fromclip=@+
                                            "00 . 00 . 00(00)
    let fromclip=substitute(fromclip, "\\s\\?\\(\\d\\{2}\\.\\)\\{2}\\d\\{2,4}\\s\\?", "", "")
    let fromclip=substitute(fromclip, "\\s\\?\\d\\{2,4}p$", "", "")
    let fromclip=substitute(fromclip, "\\.(mkv|mp4|webm|avi|nfo)", "", "")
    let fromclip=substitute(fromclip, "\\s*$", "", "")

    exec "sil %s/".pattern."/".fromclip."/"
endfunc

func! s:renameTorrent() abort
  echom "Here in rename-torrents.vim#renameTorrent"
  norm! 0f.r 3;ld0
  silent! s/\./ /g
  silent! s/X\{3}.*//g
  exe "norm! $p2Bi- "
  exe "norm! 02ea -"
  silent! s/\.$//

  silent! .g/\( - [aA]nd\)/s//,/ | norm! 04Ea -
endfunc
" Commands
command! RenameFromClipboard :call <SID>renameFromClipboard()
command! RenameTorrent :call <SID>renameTorrent()
