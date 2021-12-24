--- TODO: Can we set default options before vim-sleuth?
--
vim.wo.signcolumn = 'yes'

vim.bo.expandtab = true
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4

vim.bo.textwidth = 79
vim.api.nvim_command("setlocal formatoptions+=tcrn1 formatoptions-=o")
vim.api.nvim_command("setlocal cinoptions+=l1,:n1")

-- Set up the CCLS language server.
require('lspconfig').ccls.setup({
  init_options = {
    single_file_support = true,
    cache = {
	directory = "/home/lala/.cache/ccls";
    };
    compilationDatabaseDirectory = "build";
    index = {
      threads = 1;
    };
    clang = {
      excludeArgs = { "-frounding-math"};
    };
  }
})

-- Set up Clangd for good measure.
-- It gives us single file support, and is backed by Google etc.
require'lspconfig'.clangd.setup{}
