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
nnoremap <leader>sr :MoveToShrinkRay<cr>j
nnoremap <localleader>sr :%norm ,sr<cr>
nnoremap <leader>hm :HowMany<cr>gg

" Functions
func! s:renameFromClipboard() abort
    echom "Here in rename-torrents.vim#renameFromClipboard"
    let verymagicbeginning="\\v^\\&?\\zs.*\\ze"
    let dashorcolon="(([:-]\\d{2}){3}\\.\\d{3}_.*\\.jpg|\\.(mkv|mp4|webm|avi|vid|nfo))"
    let dateswdots="-(\\d{2}\\.){2}\\d{2}-\\d{3}\\.jpg"
    let pattern=verymagicbeginning."(".dashorcolon."|".dateswdots.")"."$"
    let fromclip=@+
                                            "00 . 00 . 00(00)
    let fromclip=substitute(fromclip, "\\s\\?\\(\\d\\{2}\\.\\)\\{2}\\d\\{2,4}\\s\\?", "", "")
    let fromclip=substitute(fromclip, "\\.\\(mkv\\|mp4\\|webm\\|avi\\|nfo\\)$", "", "")
    let fromclip=substitute(fromclip, "\\s\\?\\d\\{2,4}p\\s*$", "", "")
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

func! s:moveToShrinkRay() abort
  exe "r! pwd" | exe "norm [eA/tmp/old/kjgJ"
endfunc

func! s:howMany() abort
  sil v/.jpg$/d
  sil %s/-\d\d-\d\d\-\d\d.\d\d\d.*.jpg$// | %!uniq -c
  sil sort! n
  sil %s/\w /&: /
endfunc

" Commands
command! RenameFromClipboard :call <SID>renameFromClipboard()
command! RenameTorrent :call <SID>renameTorrent()
command! MoveToShrinkRay :call <SID>moveToShrinkRay()
command! HowMany :call <SID>howMany()



" These commands are for looling through count_images.py output
nnoremap <plug>(snag_name) 0f:wv$h"+y
nnoremap <buffer> <localleader>L <plug>(snag_name):exe 'sil !opv "' .. @+ .. '"'<cr>
nnoremap <buffer> <localleader><Enter> <plug>(snag_name):sil !opsx<cr>
nnoremap <buffer> <localleader>. <plug>(snag_name):sil !opsx -V<cr>
nmap <buffer> <localleader><localleader>. <plug>(snag_name):sil !opsx -V<cr><localleader><Enter>
nnoremap <buffer> <localleader>f <plug>(snag_name):sil !flash<cr>

nnoremap <localleader>v :exe "sil !mpv ./\"" . getline(".") . '"'<cr>
nnoremap <localleader>D mz:s/(\(\d\?\d\)[.-]\(\d\?\d\)[.-]\d\d\(\d\d\))/\3-\2-\1/<cr>`z
nnoremap <localleader>4 G$ciwmp4<esc>
