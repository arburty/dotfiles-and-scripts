-- localmachine set in zshrc
local mymachine = vim.env.localmachine
local browser = "gio open"
-- local servicenowlink = "www.google.com"
local servicenowlink = "https://invesco.service-now.com/com.glideapp.servicecatalog_cat_item_view.do?v=1&sysparm_id=59eb77f913865f886d957e776144b018&sysparm_link_parent=5b183856138e1bc86d957e776144b0de&sysparm_catalog=e0d08b13c3330100c8b837659bba8fb4&sysparm_catalog_view=catalog_default&sysparm_view=catalog_default"
if mymachine == "WSL"
then -- Invesco specific
  browser = "msedge.exe"
end

-- Autocmds
local sft = vim.api.nvim_create_augroup("CustomSnoteFt", {clear = true})

vim.api.nvim_create_autocmd({"BufWritePost"}, {
  pattern = {"*.snote"},
  group = sft,
  callback = function() 
    local file = vim.fn.expand('<afile>')
    print ( file .. " was saved" ) 
  end
})

-- Set the filtype to markdown.
-- Doing it in BufWinEnter fixed the colorscheme bug.
vim.api.nvim_create_autocmd({"BufWinEnter"}, {
  pattern = {"*.snote"},
  group = sft,
  callback = function() 
    vim.bo.filetype = "markdown"
  end
})

-- Keymappings
-- local keymap = vim.api.nvim_set_keymap
local keymap = vim.api.nvim_buf_set_keymap
local opts = { noremap = true, silent = true}

keymap(0, "n", "<leader>em", "<cmd>r ~/Templates/email_to_mehvish.txt<cr>", opts)
keymap(0, "n", "<leader>ni", "<cmd>r ~/Templates/non_issue_tasks.txt<cr>", opts)

keymap(0, "n", "<leader>cm", "r<c-k>RT", opts)
keymap(0, "n", "<Enter>", 'mz<cmd>s/\\[\\zs\\(X\\| \\)\\?\\ze\\]/√/<cr>`z', opts)

keymap(0, "n", "<Plug>(snote_toTop)", '<cmd>exe "norm mzgg"<cr>', opts)
keymap(0, "n", "<leader>gg", '<Plug>(snote_toTop)<cmd>/^\\(┌\\|┏\\|┍\\|┎\\)\\?|><cr>', opts)

-- Could not for the life of me get this to work until I broke it up like this
keymap(0, "n", "<Plug>(snote_findJira)", '<Plug>(snote_toTop)<cmd>/\\[Jira\\]<cr>', opts)
keymap(0, "n", "<leader>oj", '<Plug>(snote_findJira)<cmd>norm gx`z<cr>', opts)


-- Opening Fortify links.
keymap(0, "n", "<Plug>(snote_openAllIssues)", '<cmd>sil! g;\\[Issue_;norm gx<cr>', opts)
keymap(0, "n", "<Plug>(snote_openIssueNumber)", '<cmd>sil! exe "g;\\\\[Issue_" . v:count . ";norm gx"<cr>', opts)
keymap(0, "n", "<leader>of", "mz<Plug>(snote_openAllIssues)`z", opts)
keymap(0, "n", "<leader>oi", '<cmd>exe "norm mz" . v:count . "<Plug>(snote_openIssueNumber)"<cr>`z', opts)

keymap(0, "n", "<leader>sn"
  , string.format("<cmd>put '%s'<cr>", servicenowlink)
  -- , string.format("<cmd>lua print('%s %s 1>/dev/null 2>&1')<cr>", browser, servicenowlink)
  -- , string.format("<cmd>lua os.execute('%s %s 1>/dev/null 2>&1')<cr>", browser, servicenowlink)
  , opts)
-- lua os.execute('msedge.exe https://invesco.service-now.com/com.glideapp.servicecatalog_cat_item_view.do?v=1&sysparm_id=59eb77f913865f886d957e776144b018&sysparm_link_parent=5b183856138e1bc86d957e776144b0de&sysparm_catalog=e0d08b13c3330100c8b837659bba8fb4&sysparm_catalog_view=catalog_default&sysparm_view=catalog_default 1>/dev/null 2>&1')
