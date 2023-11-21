
print("Hello from LunarVim user keymaps")

local source_keymaps = vim.api.nvim_create_augroup("source_keymaps", {clear = true})
vim.api.nvim_create_autocmd({"BufWritePost"}, {
  pattern = {"keymaps.lua"},
  group = source_keymaps,
  command = "source " .. vim.fn.expand('<afile>')
})

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- Start Mappings

keymap("n", "zl", "zL", opts)
keymap("n", "zh", "zH", opts)

-- Nerdtree
keymap("n", "<leader>ee", "<cmd>lua require('nvim-tree.api').tree.toggle({find_file=true})<cr>", opts)
keymap("n", "<leader>ea", "<cmd>lua require('nvim-tree.api').tree.toggle({ path='/Users/austinburt/viking/aem-api/' , find_file = true })<cr><cmd>cd ~/viking/aem-api/<cr>", opts)

keymap("n", "<leader>L", ":bnext<CR>", opts)
keymap("n", "<leader>H", ":bprevious<CR>", opts)

keymap("i", "kj", "<ESC>", opts)

keymap("n", "_o", ":<c-u>norm <c-r>=v:count . \"[ \" . v:count . \"] \"<cr><cr>",
    { noremap = false, silent = true })
keymap("v", "_o", ":<c-u>norm <c-r>=\"'<\" . v:count . \"[ '>\" . v:count . \"] \"<cr><cr>",
    { noremap = false, silent = true })

-- Save and quit
keymap("n", "<leader>s", "<cmd>w<cr>", opts)
keymap("n", "<leader>q", "<cmd>q!<cr>", opts)

-- Telescope
--keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
keymap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
keymap("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", opts)
keymap("n", "<leader>fj", "<cmd>lua require('telescope.builtin').jumplist()<cr>", opts)
keymap("n", "<leader>fd", "<cmd>lua require('telescope.builtin').diagnostics()<cr>", opts)
keymap("n", "<leader>fr", "<cmd>lua require('telescope.builtin').resume()<cr>", opts)
keymap("n", "<leader>fM", "<cmd>lua require('telescope.builtin').man_pages()<cr>", opts)
keymap("n", "<leader>fH", "<cmd>lua require('telescope.builtin').command_history()<cr>", opts)
keymap("n", "<leader>fC", "<cmd>lua require('telescope.builtin').commands()<cr>", opts)
--[[ keymap("n", "z=", "<cmd>Telescope spell_suggest<cr>", opts) ]]
keymap("n", "z=", "<cmd>lua require('telescope.builtin').spell_suggest()<cr>", opts)

keymap("n", "<c-t>", "<cmd>Telescope live_grep<cr>", opts)

-- Leader Mappings --
keymap("n", "<leader>;", "q:", term_opts)

keymap("c", "%%", "<C-R>=fnameescape(expand('%:h')).'/'<cr>", term_opts)

keymap("n", "<leader>lb", "<cmd>vs #<cr>", term_opts)

keymap("n", "<leader>m", "<cmd>MerginalToggle<cr>", term_opts)
keymap("n", "<leader>M", "<cmd>messages<cr>", term_opts)

keymap("n", "[c", "<cmd>Gitsigns prev_hunk<cr>", opts)
keymap("n", "]c", "<cmd>Gitsigns next_hunk<cr>", opts)
keymap("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<cr>", opts)
keymap("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>", opts)
keymap("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<cr>", opts)
keymap("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>", opts)
keymap("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<cr>", opts)
keymap("n", "<leader>hB", "<cmd>Gitsigns blame_line<cr>", opts)
keymap("n", "<leader>hD", "<cmd>Gitsigns diffthis<cr>", opts)

keymap("n", "<leader>gB", "<cmd>Git blame<cr>", opts)
keymap("n", "<leader>gg", "<cmd>Git<cr>", opts)

keymap("n", "gwJ", [[vip:join<cr>]], opts)

keymap("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
keymap("n", "<leader>lI", "<cmd>Mason<cr>", opts)

keymap("v", "<leader>a", "<Plug>(EasyAlign)", opts)
keymap("v", "ga", "<Plug>(LiveEasyAlign)", opts)