local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

require("nvim-treesitter.install").prefer_git = true

configs.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { 
    "haskell",
    "markdown",
    "hack",
    "help",
    "embedded_template",
    "proto",
    "m68k",
    "wgsl",
    "elm",
    "slint",
    "fortran",
    "verilog",
    "org",
    "astro",
    "swift",
    "scheme",
    "todotxt",
    "foam",
  },
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { "yaml" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}

