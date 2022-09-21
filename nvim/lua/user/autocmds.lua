-- My lua autocmds

local cft = vim.api.nvim_create_augroup("CustomFileTypes", {clear = true})
vim.api.nvim_create_autocmd({"BufRead"}, {
  pattern = {"*.snote"},
  group = cft,
  callback = function() vim.bo.filetype = "snote" end
})

vim.api.nvim_create_autocmd({"BufRead"}, {
  pattern = {"*-script.sh"},
  group = cft,
  callback = function() vim.api.nvim_buf_set_keymap(0, "n", "\\z", "<cmd>!%<cr>", {noremap = true, silent = true }) end
})


local sft = vim.api.nvim_create_augroup("SetFileTypes", {clear = true})
vim.api.nvim_create_autocmd({"BufRead"}, {
  pattern = {".gitconfig","gitconfig"},
  group = cft,
  callback = function() vim.bo.filetype = "conf" end
})
