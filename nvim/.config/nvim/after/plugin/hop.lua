-- Legacy
vim.g.EasyMotion_do_mapping = 0
vim.g.EasyMotion_smartcase = 1

require('hop').setup()

-- TODO: Ask in the matrix room how to get highlights working. 
-- Nothing we do here seems to work. Been changing up the colors etc. 
-- We've installed fractal, a matrix client. use this to ask the developers in
-- the matrix room. 
-- Alternately, copy TJ's prompt. 
vim.api.nvim_command('highlight HopNextKey  guifg=#00dfff gui=bold ctermfg=45 cterm=bold')
vim.api.nvim_command('highlight HopNextKey1 guifg=#00dfff gui=bold ctermfg=45 cterm=bold')
vim.api.nvim_command('highlight HopNextKey2 guifg=#2b8db3 ctermfg=33')
vim.api.nvim_command('highlight HopUnmatched guifg=#666666 guibg=bg guisp=#666666 ctermfg=242')
vim.api.nvim_command('highlight link HopCursor Cursor')
vim.api.nvim_command('augroup HopInitHighlight')
vim.api.nvim_command('autocmd!')
vim.api.nvim_command("autocmd ColorScheme * lua require'hop.highlight'.insert_highlights()")
vim.api.nvim_command('augroup end')
