-- My lua autocmds

local cft = vim.api.nvim_create_augroup("CustomFileTypes", {clear = true})
vim.api.nvim_create_autocmd({"BufRead"}, {
  pattern = {"*.snote"},
  group = cft,
  callback = function() vim.bo.filetype = "snote" end
})

local sft = vim.api.nvim_create_augroup("SetFileTypes", {clear = true})
vim.api.nvim_create_autocmd({"BufRead"}, {
  pattern = {".gitconfig","gitconfig"},
  group = cft,
  callback = function() vim.bo.filetype = "conf" end
})
