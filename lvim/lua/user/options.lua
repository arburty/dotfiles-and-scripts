-- LunarVim options

vim.opt.relativenumber = true

-- Add it once I fix highlight color in pop-punk
--[[ vim.opt.foldmethod = "expr" ]]
--[[ vim.opt.foldexpr = "nvim_treesitter#foldexpr()" ]]

lvim.colorscheme = "pop-punk"

-- vim.bo.opt.foldmarker="{,}"
-- vim.bo.opt.foldmethod="marker"
-- vim.bo.opt.foldlevel=1

vim.opt.foldmethod = "expr" -- default is "normal"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- default is ""
vim.opt.foldenable = false -- if this option is true and fold method option is other than normal, every time a document is opened everything will be folded.
