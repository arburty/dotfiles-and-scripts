-- colorscheme.lua
-- Author : Austin Burt
-- Email  : austin@burt.us.com
-- Date   :

vim.cmd [[
try
  " colorscheme darkplus
  colorscheme pop-punk
  " a softer Visual Select. Defualt bright white
  hi Visual ctermfg=148 ctermbg=240 guifg=#afdf00 guibg=#585858
  " a red highlight
  hi IncSearch ctermfg=15 ctermbg=161 guifg=#ffffff guibg=#d70061
  hi Folded term=standout cterm=italic ctermfg=White ctermbg=236 gui=italic guifg=#a0a8b0 guibg=#384048
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme torte
  set background=dark
  hi Folded term=standout cterm=italic ctermfg=14 ctermbg=236 gui=italic guifg=#a0a8b0 guibg=#384048
  hi clear SignColumn      " SignColumn should match background
endtry
]]
