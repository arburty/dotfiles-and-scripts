
local keymap = vim.api.nvim_buf_set_keymap
local opts = { noremap = true, silent = true}

keymap(0, "n", "<c-p>", "<cmd>Glow!<cr>", opts)

keymap(0, "n", "<localleader>a", "mz<cmd>?^$?,/^$/EasyAlign *| {'a': 'c', 'rm': 0, 'lm': 0}<cr>`zzz", opts)

-- Table help

-- nnoremap \a mz:c--`zzz
--'<,'>g/==/s/\s/=/g
-- ?^$?,/^$/EasyAlign *| {'a': 'c', 'rm': 0, 'lm': 0}
