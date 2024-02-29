
-- source ./wsl_clip.vim
local debug=false
if debug then print("hello from plugin") end

local home = vim.env.HOME
local lvim_root = home .. "/git/dotfiles-and-scripts/lvim"
local vimscript_path = lvim_root .. "/lua/user/plugin/"

local vimscript_files = {}
vim.list_extend(vimscript_files, vim.split(vim.fn.glob(vimscript_path .. "*.vim"), "\n"))

if debug then
  print("root path: " .. vimscript_path)
  for i, file in pairs(vimscript_files) do
    print(i .. ": " .. file)
  end
  print ("\n")
end

local function sourceVimScript(i, path)
  if debug then print ("sourcing " .. i .. ": " .. path) end
  vim.cmd("source " .. path)
end

table.foreach(vimscript_files, sourceVimScript)

