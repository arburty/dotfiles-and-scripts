local status_ok, nvimtree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- require("nvim-tree").setup {
nvimtree.setup {
  view = {
    width = 50,
    number = true,
    relativenumber = true,
    mappings = {
      custom_only = false,
      list = {
        keymap("n", "<left>", "<cmd>NvimTreeResize -10<cr>", opts),
        keymap("n", "<right>", "<cmd>NvimTreeResize +10<cr>", opts),
      },
    },
  },
  update_focused_file = {
    enable = true,
    update_root = false,
    ignore_list = {},
  },
}
