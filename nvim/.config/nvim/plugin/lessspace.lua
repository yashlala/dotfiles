--[[ Configuration for the `lessspace.vim` plugin. ]]

-- Only trim trailing whitespace when in insert mode. 
vim.g.lessspace_normal = 0

-- Don't trim trailing whitespace for some filetypes. 
vim.g.lessspace_blacklist = { 'diff', 'markdown' }
