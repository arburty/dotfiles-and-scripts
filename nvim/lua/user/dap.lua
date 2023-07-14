local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end

local utils = require'utils'

local store_mapleader = vim.g.mapleader
vim.g.mapleader = '\\'

-- key_mapping --
local key_map = function(mode, key, result)
  vim.api.nvim_set_keymap(
    mode,
    key,
    result,
    {noremap = true, silent = true}
  )
end

-- run debug
local function get_test_runner(test_name, debug)
  if debug then
    return 'mvn test -Dmaven.surefire.debug -Dtest="' .. test_name .. '"'
  end
  return 'mvn test -Dtest="' .. test_name .. '"'
end

function Run_java_test_method(debug)
  local method_name = utils.get_current_full_method_name("\\#")
  vim.cmd('term ' .. get_test_runner(method_name, debug))
end

function Run_java_test_class(debug)
  local class_name = utils.get_current_full_class_name()
  vim.cmd('term ' .. get_test_runner(class_name, debug))
end

function Get_spring_boot_runner(profile, debug)
  local debug_param = ""
  if debug then
    debug_param = ' -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005" '
  end

  local profile_param = ""
  if profile then
    profile_param = " -Dspring-boot.run.profiles=" .. profile .. " "
  end

  return 'mvn clean install -PautoInstallSinglePackage'
end

function Run_spring_boot(debug)
  local method_name = utils.get_current_full_method_name("\\#")
  vim.cmd('term ' .. Get_spring_boot_runner(method_name, debug))
end

vim.keymap.set("n", "<leader>tm", function() Run_java_test_method() end)
vim.keymap.set("n", "<leader>TM", function() Run_java_test_method(true) end)
vim.keymap.set("n", "<leader>tc", function() Run_java_test_class() end)
vim.keymap.set("n", "<leader>TC", function() Run_java_test_class(true) end)
vim.keymap.set("n", "<F9>", function() Run_spring_boot() end)
--[[ vim.keymap.set("n", "<F10>", function() Run_spring_boot(true) end) ]]

-- setup debug
key_map('n', '<leader>b', ':lua require"dap".toggle_breakpoint()<CR>')
key_map('n', '<leader>B', ':lua require"dap".set_breakpoint(vim.fn.input("Condition: "))<CR>')
key_map('n', '<leader>bl', ':lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log: "))<CR>')
key_map('n', '<leader>dr', ':lua require"dap".repl.open()<CR>')

-- telsecope dap
key_map('n', '<leader>lb', ':lua require"telescope".extensions.dap.list_breakpoints{}<CR>')
key_map('n', '<leader>lc', ':lua require"telescope".extensions.dap.commands{}<CR>')
key_map('n', '<leader>lC', ':lua require"telescope".extensions.dap.configurations{}<CR>')
key_map('n', '<leader>lv', ':lua require"telescope".extensions.dap.variables{}<CR>')
key_map('n', '<leader>lf', ':lua require"telescope".extensions.dap.frames{}<CR>')

-- view informations in debug
function Show_dap_centered_scopes()
  local widgets = require'dap.ui.widgets'
  widgets.centered_float(widgets.scopes)
end
key_map('n', 'gs', ':lua Show_dap_centered_scopes()<CR>')

-- move in debug
key_map('n', '<F5>', ':lua require"dap".continue()<CR>')
key_map('n', '<F8>', ':lua require"dap".step_over()<CR>')
key_map('n', '<F7>', ':lua require"dap".step_into()<CR>')
key_map('n', '<S-F8>', ':lua require"dap".step_out()<CR>')


function Attach_to_debug()
  dap.configurations = {
    {
      type = 'java';
      request = 'attach';
      name = "Attach to Adobe AEM p8888";
      hostName = 'localhost';
      port = '8888';
    },
    {
      type = 'java';
      request = 'attach';
      name = "Attach to Adobe AEM p4502";
      hostName = 'localhost';
      port = '4502';
    },
  }
  dap.continue()
end

key_map('n', '<leader>da', ':lua Attach_to_debug()<CR>')


-- restore global mapleader
vim.g.mapleader = store_mapleader
