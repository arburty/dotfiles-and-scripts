-- plugins.lua
-- Author : Austin Burt
-- Email  : austin@burt.us.com
-- Date   : 01/05/2022
--
-- Used to install plugins for Neovim

-- Bootstrapping {{{
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}
--}}}

-- Install Plugins {{{
-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim"    -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim"  -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs"  -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim"  -- Easily comment stuff
  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'
  use "moll/vim-bbye"

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"
  use "f3fora/cmp-spell"
  use "rcarriga/cmp-dap"

  -- Language specific
  use "mfussenegger/nvim-jdtls"
  use 'mfussenegger/nvim-dap'

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- colorschemes
  use "lunarvim/darkplus.nvim"
  use "bignimbus/pop-punk.vim"

  -- Aesthetics
  use "akinsho/bufferline.nvim"

  -- LSP
	use { "neovim/nvim-lspconfig", commit = "f11fdff7e8b5b415e5ef1837bdcdd37ea6764dda" } -- enable LSP
  use { "williamboman/mason.nvim", commit = "c2002d7a6b5a72ba02388548cfaf420b864fbc12"} -- simple to use language server installer
  use { "williamboman/mason-lspconfig.nvim", commit = "0051870dd728f4988110a1b2d47f4a4510213e31" }
  -- use { "jose-elias-alvarez/null-ls.nvim", commit = "c0c19f32b614b3921e17886c541c13a72748d450" } -- for formatters and linters
  use { "RRethy/vim-illuminate", commit = "d6ca7f77eeaf61b3e6ce9f0e5a978d606df44298" }

  use "simrat39/symbols-outline.nvim"

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-media-files.nvim"
  use "nvim-telescope/telescope-dap.nvim"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "p00f/nvim-ts-rainbow"
  use "nvim-treesitter/playground"
  use "JoosepAlviste/nvim-ts-context-commentstring"

  -- Git
  use "lewis6991/gitsigns.nvim"
  use "tpope/vim-fugitive"
  use "idanarye/vim-merginal"
  use "tpope/vim-rhubarb" -- GitHub
  use "shumphrey/fugitive-gitlab.vim" -- GitLab
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }


  -- Docs
  use 'wsdjeg/luarefvim'

  use "mbbill/undotree"
  --use 'scrooloose/nerdcommenter'
  use "tpope/vim-abolish"
  use "tpope/vim-repeat"
  -- use "tpope/vim-surround"
  use "kylechui/nvim-surround"
  use "romainl/vim-cool"
  use "justinmk/vim-sneak"
  use "tpope/vim-unimpaired"
  -- use "JamshedVesuna/vim-markdown-preview"
  use "ellisonleao/glow.nvim"
  use 'junegunn/vim-easy-align'

  -- }}}

  -- Finish Bootstrap {{{
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
--}}}

-- Modeline{{{
-- vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker:}}}
