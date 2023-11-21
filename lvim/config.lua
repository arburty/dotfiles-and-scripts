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

  "tpope/vim-unimpaired",
  "kylechui/nvim-surround",
  'junegunn/vim-easy-align',

  -- Colorschemes
  "lunarvim/darkplus.nvim",
  "sainnhe/sonokai",
  "bignimbus/pop-punk.vim",
}


vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })

require("user.keymaps")
require("user.options")
