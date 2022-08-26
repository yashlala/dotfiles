vim.wo.signcolumn = 'yes'

vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.textwidth = 79

vim.api.nvim_command("setlocal formatoptions+=cr formatoptions-=o")
vim.api.nvim_command("setlocal cinoptions+=l1,:n1")
