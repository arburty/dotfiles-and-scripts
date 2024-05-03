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

lvim.autocommands = {
  {
    { "ColorScheme" },
    {
      pattern = "*",
      callback = function()
        -- change `Normal` to the group you want to change
        -- and `#ffffff` to the color you want
        -- see `:h nvim_set_hl` for more options
        --[[ vim.api.nvim_set_hl(0, "Visual", { fg = "#afdf00", bg = "#d70061", underline = false, bold = false }) ]]
        vim.api.nvim_set_hl(0, "Visual", { fg = "#afdf00", bg = "#323c44", underline = false, bold = true })
        vim.api.nvim_set_hl(0, "IncSearch", { bg = "#d70061", underline = true, bold = true , standout=true})
        vim.api.nvim_set_hl(0, "Folded", { bg = "#ffffff", fg = "#384048", underline = false, italic = true , standout = true })
      end,
    },
  },
}


vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })

require("user.keymaps")
require("user.options")
require("user.nvimtree")
require("nvim-surround").setup{}
require("user.plugin")
