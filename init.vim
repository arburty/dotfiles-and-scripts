" init.vim
" Author : Austin Burt
" Email  : austin@burt.us.com 
" Date   : 06/22/20

" Source my Vimrc setup
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

" neovim stuff and stuff {




" }

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> <leader>r <Plug>(coc-rename)

" Modeline{
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker:}
