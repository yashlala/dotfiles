--[[ Configuration for the `lessspace.vim` plugin. ]]

-- TODO: This plugin causes problems with Telescope preview windows.
-- Disable it until that issue is fixed.
vim.g.lessspace_enabled = 0;

-- Only trim trailing whitespace when in insert mode. 
vim.g.lessspace_normal = 0

-- Don't trim trailing whitespace for some filetypes. 
vim.g.lessspace_blacklist = { 'diff', 'markdown' }
