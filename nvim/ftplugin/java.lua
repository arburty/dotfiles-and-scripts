--See https://github.com/mfussenegger/nvim-jdtls
-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.

--vim.lsp.set_log_level("debug")

vim.bo.expandtab = false -- convert tabs to spaces
vim.bo.tabstop = 4      -- insert 4 4paces for a tab
vim.bo.shiftwidth = 0   -- the number of spaces inserted for each indentation

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local home = vim.env.HOME
local workspace_dir = home .. '/.cache/java_workspace/' .. project_name
-- localmachine set in zshrc
local mymachine = vim.env.localmachine

local javaargs

if mymachine == "WSL"
then -- Invesco specific
  local catalina_base = '/mnt/c/projects/' .. project_name .. '/.metadata/.plugins/org.eclipse.wst.server.core/tmp1'
  local deploy = catalina_base .. '/wtpwebapps'

  javaargs = {
    --'java', -- or '/path/to/java11_or_newer/bin/java'
    '/opt/jdk-17/bin/java',


-- ==== GRADLE =======
    '-Xmx1024m',
    '-Djasypt.encryptor.password=Invesco123',

-- ==== MAGNOLIA =====
--    '${jrebel_args}',
--    '-Dcatalina.base=' .. catalina_base,
    --'-Dcatalina.home=/mnt/c/usr/local/java/apache-tomcat-9.0.31',
--    '-Dwtp.deploy=' .. deploy,
    --'--add-opens=java.base/java.lang=ALL-UNNAMED',
    --'--add-opens=java.base/java.io=ALL-UNNAMED',
    --'--add-opens=java.base/java.util=ALL-UNNAMED',
    --'--add-opens=java.base/java.util.concurrent=ALL-UNNAMED',
    --'--add-opens=java.rmi/sun.rmi.transport=ALL-UNNAMED',
    --'--add-modules=ALL-SYSTEM',
-- ===== END =========

    '-Dinvesco.ad.access=Inve5co',
    '-Doauth.access=Invesco123',

    -- 💀
    '-jar', home .. '/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher.gtk.linux.x86_64_1.2.400.v20211117-0650.jar',
    -- 💀
    '-configuration', './config_linux/config.ini',
    -- 💀
    '-data', workspace_dir
  }
else -- default args
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

    '--module-path', 'astro-modules/astro-dev.main',
    --[[ '--module-path', 'astro-dev/com.astro.dmp.dev.Application', ]]
    --[[ '--module com.jenkov.mymodule/com.jenkov.mymodule.Main' ]]
    '-Xmx1024m',

    -- 💀
    --[[ '-jar', home .. '/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher.gtk.linux.x86_64_1.2.400.v20211117-0650.jar', ]]
    '-jar', home .. '/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher.cocoa.macosx.x86_64_1.2.400.v20211117-0650.jar',
    -- 💀
    --[[ '-configuration', './config_linux/config.ini', ]]
    '-configuration', './config_mac/',
    -- 💀
    '-data', workspace_dir
  }

end

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
    bundles = {}
  },
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.

require('jdtls').start_or_attach(config)
--local status_ok, _ = pcall( require, ('jdtls').start_or_attach(config) )
--if not status_ok then
--  vim.api.nvim_notify("nvim/ftplugin/java.lua not sourced")
--end
