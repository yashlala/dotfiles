--- TODO: Can we set default options before vim-sleuth? 
--
vim.wo.signcolumn = 'yes'

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
