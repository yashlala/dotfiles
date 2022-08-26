-- TODO: Should autostart the LSP server.
-- Not working for some reason, we need to manually :LspStart

vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.textwidth = 79
vim.api.nvim_command('setlocal formatoptions+=cr1 formatoptions-=o')
