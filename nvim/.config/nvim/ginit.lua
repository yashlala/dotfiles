vim.o.termguicolors = true
vim.cmd('colorscheme zenburned')

-- Enable Mouse
vim.o.mouse = 'a'

if vim.fn.exists(':GuiFont') then
    vim.cmd('GuiFont DejaVu Sans Mono:h11')
end

-- vim-ezguifont plugin
vim.keymap.set('n', '<C-=>', '<cmd>IncreaseFont<cr>')
vim.keymap.set('n', '<C-+>', '<cmd>IncreaseFont<cr>')
vim.keymap.set('n', '<C-->', '<cmd>DecreaseFont<cr>')

-- Disable GUI Tabline
if vim.fn.exists(':GuiTabline') then
    vim.cmd('GuiTabline 0')
end

-- Disable GUI Popupmenu
if vim.fn.exists(':GuiPopupmenu') then
    vim.cmd('GuiPopupmenu 0')
end

-- Right Click Context Menu (Copy-Cut-Paste)
vim.cmd([[
    nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
    inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
    xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
    snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv
]])

-- Raise GUI font menu to pick a new font
vim.api.nvim_create_user_command('ChangeFont', 'set guifont=*', {})
