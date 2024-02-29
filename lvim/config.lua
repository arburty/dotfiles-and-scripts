-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.plugins = {
  "mfussenegger/nvim-jdtls",

  -- more git stuff
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb", -- GitHub
  "idanarye/vim-merginal",

  -- Quality of life plugins
  {"kylechui/nvim-surround", lazy = false},
  "tpope/vim-unimpaired",
  "junegunn/vim-easy-align",
  "junegunn/fzf",

  -- Colorschemes
  "lunarvim/darkplus.nvim",
  "sainnhe/sonokai",
  "bignimbus/pop-punk.vim",

  -- Better Quick Fix
  "kevinhwang91/nvim-bqf",
  event = { "BufRead", "BufNew" },
  config = function()
    require("bqf").setup({
      auto_enable = true,
      preview = {
        win_height = 12,
        win_vheight = 12,
        delay_syntax = 80,
        border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
      },
      func_map = {
        vsplit = "<C-v>",
        ptogglemode = "z,",
        stoggleup = "",
      },
      filter = {
        fzf = {
          action_for = { ["ctrl-s"] = "split" },
          extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
        },
      },
    })
  end,
}



vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })

require("user.keymaps")
require("user.options")
require("user.nvimtree")
require("nvim-surround").setup{}
require("bqf")
