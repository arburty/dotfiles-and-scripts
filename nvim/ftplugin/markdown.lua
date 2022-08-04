
local keymap = vim.api.nvim_buf_set_keymap
local opts = { noremap = true, silent = true}

keymap(0, "n", "<c-p>", "<cmd>Glow!<cr>", opts)
