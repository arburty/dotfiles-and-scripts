--See https://github.com/mfussenegger/nvim-jdtls
-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = '~/.cache/java_workspace/' .. project_name

local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    -- 💀
    'java', -- or '/path/to/java11_or_newer/bin/java'
            -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    -- '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    -- '-Dosgi.bundles.defaultStartLevel=4',
    -- '-Declipse.product=org.eclipse.jdt.ls.core.product',
    -- '-Dlog.protocol=true',
    -- '-Dlog.level=ALL',
    -- '-Xms1g',
    -- '--add-modules=ALL-SYSTEM',
    -- '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    -- '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    '${jrebel_args}',
    '-Dcatalina.base="/mnt/c/projects/us-magnolia-sunset/.metadata/.plugins/org.eclipse.wst.server.core/tmp0"',
    '-Dcatalina.home="/mnt/c/usr/local/java/apache-tomcat-9.0.31"',
    '-Dwtp.deploy="/mnt/c/projects/us-magnolia-sunset/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps"',
    '--add-opens=java.base/java.lang=ALL-UNNAMED',
    '--add-opens=java.base/java.io=ALL-UNNAMED',
    '--add-opens=java.base/java.util=ALL-UNNAMED',
    '--add-opens=java.base/java.util.concurrent=ALL-UNNAMED',
    '--add-opens=java.rmi/sun.rmi.transport=ALL-UNNAMED',
    '-Dinvesco.ad.access=Inve5co',
    '-Doauth.access=Invesco123',

    -- 💀
    --'-jar', '~/.local/share/eclipse-server/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher.gtk.linux.x86_64_1.2.400.v20211117-0650.jar',
    '-jar', '~/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher.gtk.linux.x86_64_1.2.400.v20211117-0650.jar',

    -- 💀
    '-configuration', './config_linux/config.ini',
                    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
                    -- Must point to the                      Change to one of `linux`, `win` or `mac`
                    -- eclipse.jdt.ls installation            Depending on your system.


    -- 💀
    -- See `data directory configuration` section in the README
    '-data', workspace_dir
  },

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),

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
  --vim.api.nvim_notify("nvim/ftplugin/java.lua not sourced")
--end
