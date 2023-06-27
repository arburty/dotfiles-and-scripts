local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end

print("in dap world.")
local M = {}

--[[ dap.configurations.java = { ]]
--[[   { ]]
--[[     type = 'java'; ]]
--[[     request = 'attach'; ]]
--[[     name = "Debug (Attach) - Remote"; ]]
--[[     hostName = "127.0.0.1"; ]]
--[[     port = 4502; ]]
--[[   }, ]]
--[[ } ]]


-- PART 4 - Keymaps --
-- Keymaps --

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
function M.get_test_runner(test_name, debug)
  if debug then
    return 'mvn test -Dmaven.surefire.debug -Dtest="' .. test_name .. '"'
  end
  return 'mvn test -Dtest="' .. test_name .. '"'
end

function M.run_java_test_method(debug)
  local utils = require'utils'
  local method_name = utils.get_current_full_method_name("\\#")
  vim.cmd('term ' .. M.get_test_runner(method_name, debug))
end

function M.run_java_test_class(debug)
  local utils = require'utils'
  local class_name = utils.get_current_full_class_name()
  vim.cmd('term ' .. M.get_test_runner(class_name, debug))
end

function M.get_spring_boot_runner(profile, debug)
  local debug_param = ""
  if debug then
    debug_param = ' -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005" '
  end

  local profile_param = ""
  if profile then
    profile_param = " -Dspring-boot.run.profiles=" .. profile .. " "
  end

  return 'mvn spring-boot:run ' .. profile_param .. debug_param
end

function M.run_spring_boot(debug)
  vim.cmd('term ' .. M.get_spring_boot_runner(method_name, debug))
end

vim.keymap.set("n", "<leader>tm", function() M.run_java_test_method() end)
vim.keymap.set("n", "<leader>TM", function() M.run_java_test_method(true) end)
vim.keymap.set("n", "<leader>tc", function() M.run_java_test_class() end)
vim.keymap.set("n", "<leader>TC", function() M.run_java_test_class(true) end)
vim.keymap.set("n", "<F9>", function() M.run_spring_boot() end)
vim.keymap.set("n", "<F10>", function() M.run_spring_boot(true) end)

-- setup debug
key_map('n', '<leader>b', ':lua require"dap".toggle_breakpoint()<CR>')
key_map('n', '<leader>B', ':lua require"dap".set_breakpoint(vim.fn.input("Condition: "))<CR>')
key_map('n', '<leader>bl', ':lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log: "))<CR>')
key_map('n', '<leader>dr', ':lua require"dap".repl.open()<CR>')

-- view informations in debug
function M.show_dap_centered_scopes()
  local widgets = require'dap.ui.widgets'
  widgets.centered_float(widgets.scopes)
end
key_map('n', 'gs', ':lua show_dap_centered_scopes()<CR>')

-- move in debug
key_map('n', '<F5>', ':lua require"dap".continue()<CR>')
key_map('n', '<F8>', ':lua require"dap".step_over()<CR>')
key_map('n', '<F7>', ':lua require"dap".step_into()<CR>')
key_map('n', '<S-F8>', ':lua require"dap".step_out()<CR>')


function attach_to_debug()
  dap.configurations.java = {
    {
      type = 'java';
      request = 'attach';
      name = "Attach to Adobe AEM";
      hostName = 'localhost';
      port = '4502';
    },
  }
  dap.continue()
end

key_map('n', '<leader>da', ':lua attach_to_debug()<CR>')

vim.g.mapleader = store_mapleader
