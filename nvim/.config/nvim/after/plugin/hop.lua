-- TODO: The highlights aren't working. We can fix this with
-- https://github.com/phaazon/hop.nvim/issues/154#issuecomment-1001178509
vim.api.nvim_command('highlight HopNextKey  guifg=#00dfff gui=bold ctermfg=45 cterm=bold')
vim.api.nvim_command('highlight HopNextKey1 guifg=#00dfff gui=bold ctermfg=45 cterm=bold')
vim.api.nvim_command('highlight HopNextKey2 guifg=#2b8db3 ctermfg=33')
vim.api.nvim_command('highlight HopUnmatched guifg=#666666 guibg=bg guisp=#666666 ctermfg=242')
vim.api.nvim_command('highlight link HopCursor Cursor')
vim.api.nvim_command('augroup HopInitHighlight')
vim.api.nvim_command('autocmd!')
vim.api.nvim_command("autocmd ColorScheme * lua require'hop.highlight'.insert_highlights()")
vim.api.nvim_command('augroup end')

require('hop').setup()
