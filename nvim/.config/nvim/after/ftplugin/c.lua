--- TODO: Can we set default options before vim-sleuth?
--
vim.wo.signcolumn = 'yes'

vim.bo.expandtab = true
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4

vim.bo.textwidth = 79
vim.api.nvim_command("setlocal formatoptions+=tcrn1 formatoptions-=o")
vim.api.nvim_command("setlocal cinoptions+=l1,:n1")

-- Set up Clangd for good measure.
-- It gives us single file support, and is backed by Google etc.
require'lspconfig'.clangd.setup{}
