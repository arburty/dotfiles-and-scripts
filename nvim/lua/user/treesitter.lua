
local configs = require("nvim-treesitter.configs")
--require("nvim-treesitter.install").prefer_git = true
require("nvim-treesitter.install").command_extra_args = {
  curl = { "-k" },
}
configs.setup {
  ensure_installed = "maintained",
  sync_install = false, 
  ignore_install = { "" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,

  },
  indent = { enable = true, disable = { "yaml" } },
}
