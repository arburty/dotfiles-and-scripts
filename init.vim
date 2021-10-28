" init.vim
" Author : Austin Burt
" Email  : austin@burt.us.com
" Date   : 06/22/20

" Source my Vimrc setup
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]G <Plug>(coc-diagnostic-next-error)
nmap <silent> [G <Plug>(coc-diagnostic-prev-error)
nmap <silent> <leader>rn <Plug>(coc-rename)

"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gci <Plug>(coc-implementation)
"nmap <silent> gcr <Plug>(coc-references)


if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

augroup Golang
    au!
    autocmd FileType go nnoremap <buffer> <localleader>z :term go run %<cr>
augroup END

" TODO: figure out catpuccino colorscheme

" Modeline{
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker:}
