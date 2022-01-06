-- colorscheme.lua
-- Author : Austin Burt
-- Email  : austin@burt.us.com
-- Date   :

vim.cmd [[
try
  colorscheme darkplus
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme torte
  set background=dark
endtry
]]
