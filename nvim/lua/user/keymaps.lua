--keymaps.lua
--Author : Austin Burt
--Email  : austin@burt.us.com
--Date   : 01/05/2022

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

local user_command = vim.api.nvim_create_user_command

user_command(
  "ReplaceLineWithName",
  function (input)
    local basename = ':t'
    local dirname = ':h:t'
    local name = (input.bang and basename or dirname)
    vim.api.nvim_set_current_line(vim.fn.expand('<cfile>' .. name))
  end,
  { nargs = 0 , bang = true, desc = "Replace line with the basename or directory of the file under cursor." }
)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "zl", "zL", opts)
keymap("n", "zh", "zH", opts)

keymap("n", "<leader>ee", "<cmd>lua require('nvim-tree.api').tree.toggle({find_file=true})<cr>", opts)
keymap("n", "<leader>ea", "<cmd>lua require('nvim-tree.api').tree.toggle({ path='/Users/austinburt/viking/aem-api/' , find_file = true })<cr><cmd>cd ~/viking/aem-api/<cr>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<leader>L", ":bnext<CR>", opts)
keymap("n", "<leader>H", ":bprevious<CR>", opts)

-- Insert --
-- Press kj fast to enter
keymap("i", "kj", "<ESC>", opts)

keymap("n", "_o", ":<c-u>norm <c-r>=v:count . \"[ \" . v:count . \"] \"<cr><cr>",
    { noremap = false, silent = true })
keymap("v", "_o", ":<c-u>norm <c-r>=\"'<\" . v:count . \"[ '>\" . v:count . \"] \"<cr><cr>",
    { noremap = false, silent = true })

-- Save and quit
keymap("n", "<leader>s", "<cmd>w<cr>", opts)
keymap("n", "<leader>q", "<cmd>q!<cr>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

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

--keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
keymap("n", "<c-t>", "<cmd>Telescope live_grep<cr>", opts)

-- Leader Mappings --
keymap("n", "<leader>;", "q:", term_opts)
keymap("n", "<space>", "Vj", term_opts)
keymap("v", "<space>", "}", term_opts)

keymap("n", "<leader>sv", ":source ~/.config/nvim/init.lua<cr>", {noremap = true, silent = false})

keymap("c", "%%", "<C-R>=fnameescape(expand('%:h')).'/'<cr>", term_opts)

keymap("n", "<leader>ew", ":e %%<cr>", term_opts)
keymap("n", "<leader>evs", ":vsp %%<cr>", term_opts)
keymap("n", "<leader>es", ":sp %%<cr>", term_opts)
keymap("n", "<leader>et", ":tabe %%<cr>", term_opts)

keymap("n", "<leader>lb", "<cmd>vs #<cr>", term_opts)
keymap("n", "<leader>u", "<cmd>UndotreeToggle<cr>", term_opts)

keymap("n", "<leader>m", "<cmd>MerginalToggle<cr>", term_opts)
keymap("n", "<leader>M", "<cmd>messages<cr>", term_opts)

keymap("n", "<leader>ev", "<cmd>tabnew ~/.config/nvim/init.lua<cr><cmd>lcd ~/.config/nvim<cr>", opts)
keymap("n", "<leader>ek", "<cmd>tabnew ~/.config/nvim/lua/user/keymaps.lua<cr><cmd>lcd ~/.config/nvim<cr>", opts)

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
keymap("n", "gcd", "<cmd>Gcd<cr><cmd>pwd<cr>", opts)

keymap("n", "g~", ":s;\\~;$HOME<cr>", opts)
keymap("n", "gH", ":s/$HOME/\\~/<cr>", opts)

keymap("n", "<leader>sd", "<cmd>exe 'r!desc -l ' . expand('%:t:r')<cr>kddWi<cr><c-[>", opts)

-- fixing dumb issue with <c-o> jumping back 2 spots
--keymap("n", "<c-o>", "<c-o><c-i>", opts)

keymap("n", "gx", "<cmd>sil! exe  '!msedge.exe ' . shellescape('<cWORD>')<cr>", opts)
keymap("n", "gwJ", [[vip:join<cr>]], opts)

keymap("n", "<localleader>z", [[:nnoremap <buffer> \z :]], opts)

keymap("n", "<localleader>q", "<cmd>Bdelete<cr>", opts)

keymap("n", ",bn", "<cmd>ReplaceLineWithName!<cr>", opts)
keymap("n", ",dn", "<cmd>ReplaceLineWithName<cr>", opts)

keymap("n", ",0", "<cmd>lua require'user.markdownExample'.convertFile()<CR>", opts)

keymap("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
keymap("n", "<leader>lI", "<cmd>Mason<cr>", opts)

keymap("v", "<leader>a", "<Plug>(EasyAlign)", opts)
keymap("v", "ga", "<Plug>(LiveEasyAlign)", opts)

keymap("n", "<leader>it", "<cmd>IlluminateToggle<cr>", opts)
