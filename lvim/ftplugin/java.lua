local status, jdtls = pcall(require, "jdtls")
if not status then
  return
end

vim.bo.expandtab = true -- convert tabs to spaces
vim.bo.tabstop = 4      -- insert 4 4paces for a tab
vim.bo.shiftwidth = 0   -- the number of spaces inserted for each indentation

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local home = vim.env.HOME
local workspace_dir = home .. '/.cache/java_workspace/' .. project_name
-- localmachine set in zshrc
local mymachine = vim.env.localmachine

-- Setup Capabilities
local capabilities = require("lvim.lsp").common_capabilities()
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local bundles = {}
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
vim.list_extend(bundles, vim.split(vim.fn.glob(mason_path .. "packages/java-test/extension/server/*.jar"), "\n"))
vim.list_extend(
  bundles,
  vim.split(
    vim.fn.glob(mason_path .. "packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"),
    "\n"
  )
)

local java_jar = vim.fn.glob(home .. "/.local/share/lvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar", 1)

lvim.builtin.dap.active = true

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

    -- "java",
    -- "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    -- "-Dosgi.bundles.defaultStartLevel=4",
    -- "-Declipse.product=org.eclipse.jdt.ls.core.product",
    -- "-Dlog.protocol=true",
    -- "-Dlog.level=ALL",
    -- "-Xms1g",
    -- "--add-modules=ALL-SYSTEM",
    -- "--add-opens",
    -- "java.base/java.util=ALL-UNNAMED",
    -- "--add-opens",
    -- "java.base/java.lang=ALL-UNNAMED",

  --[[ '--module-path', 'astro-modules/astro-dev.main', ]]
  --[[ '--module-path', 'astro-dev/com.astro.dmp.dev.Application', ]]
  --[[ '--module com.jenkov.mymodule/com.jenkov.mymodule.Main' ]]
  '-Xmx1024m',
  --[[ '-javaagent:' .. home .. '/.local/share/nvim/mason/packages/jdtls/lombok.jar', ]]
  '-javaagent:' .. home .. '/.local/share/lvim/mason/packages/jdtls/lombok.jar',

  -- 💀
  '-jar', java_jar,
  -- 💀
  --[[ '-configuration', './config_linux/', ]]
  '-configuration', home .. '/.local/share/lvim/mason/packages/jdtls/config_mac/',
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
  --[[ root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew', {upward = true}}), ]]
  root_dir = require("jdtls.setup").find_root { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" },
  capabilities = capabilities,

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
        },
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = "all", -- literals, all, none
        },
      },
      format = {
        enabled = false,
      },
      signatureHelp = { enabled = true },
      extendedClientCapabilities = extendedClientCapabilities,
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
}

config["on_attach"] = function(client, bufnr)
  local _, _ = pcall(vim.lsp.codelens.refresh)
	require("jdtls").setup_dap({ hotcodereplace = "auto" })
	require("lvim.lsp").on_attach(client, bufnr)
  local status_ok, jdtls_dap = pcall(require, "jdtls.dap")
  if status_ok then
    jdtls_dap.setup_dap_main_class_configs()
  end
end

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
