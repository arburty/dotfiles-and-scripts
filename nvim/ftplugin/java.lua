--See https://github.com/mfussenegger/nvim-jdtls
-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.

--vim.lsp.set_log_level("debug")
local jdtls = require("jdtls")

vim.bo.expandtab = true -- convert tabs to spaces
vim.bo.tabstop = 4      -- insert 4 4paces for a tab
vim.bo.shiftwidth = 0   -- the number of spaces inserted for each indentation

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local home = vim.env.HOME
local workspace_dir = home .. '/.cache/java_workspace/' .. project_name
-- localmachine set in zshrc
local mymachine = vim.env.localmachine

local bundles = {
  vim.fn.glob(home .. "/.local/share/nvim/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", 1)
}
vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/.local/share/nvim/vscode-java-test/server/*.jar", 1), "\n"))

local java_jar = vim.fn.glob(home .. "/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher_*.jar", 1)
print("nvim: jj : " .. java_jar)

local javaargs

javaargs = {
  'java', -- or '/path/to/java11_or_newer/bin/java'

  '-Declipse.application=org.eclipse.jdt.ls.core.id1',
  '-Dosgi.bundles.defaultStartLevel=4',
  '-Declipse.product=org.eclipse.jdt.ls.core.product',
  '-Dlog.protocol=true',
  '-Dlog.level=ALL',
  '-Xms1g',
  '--add-modules=ALL-SYSTEM',
  '--add-opens', 'java.base/java.util=ALL-UNNAMED',
  '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

  --[[ '--module-path', 'astro-modules/astro-dev.main', ]]
  --[[ '--module-path', 'astro-dev/com.astro.dmp.dev.Application', ]]
  --[[ '--module com.jenkov.mymodule/com.jenkov.mymodule.Main' ]]
  '-Xmx1024m',
  '-javaagent:' .. home .. '/.local/share/lvim/mason/share/jdtls/lombok.jar',

  -- 💀
  '-jar', java_jar,
  -- 💀
  --[[ '-configuration', './config_linux/config.ini', ]]
  '-configuration', home .. "/.local/share/nvim/lsp_servers/jdtls/config_mac/",
  -- 💀
  '-data', workspace_dir
}

local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = javaargs,

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew', {upward = true}}),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      configuration = {
        -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        -- And search for `interface RuntimeOption`
        -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
        runtimes = {
          { name = "JavaSE-11",
            path = "/usr/local/Cellar/openjdk@11/11.0.21/libexec/openjdk.jdk/Contents/Home", },
          { name = "JavaSE-17",
            path = "/usr/local/Cellar/openjdk@17/17.0.9/libexec/openjdk.jdk/Contents/Home", },
        }
      }

    }
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = bundles
  },
}

--[[ config['on_attach'] = function(client, bufnr) ]]
--[[ print('yup i git that') ]]
require('jdtls').setup_dap({ hotcodereplace = 'auto' })
--[[ end ]]

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)
