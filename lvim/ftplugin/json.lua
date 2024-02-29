

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Format Json and add a space before jcr,api,gql data structures.
keymap("n", "<localleader>f",
  '<cmd>mark z<cr><cmd>exe "norm 1 lfgg"<cr><cmd>g/^  "\\(jcr\\|api\\|gql\\)"/exe "norm [ "<cr><cmd>exe "norm 1 h`z"<cr>',
  opts)
