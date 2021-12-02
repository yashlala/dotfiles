-- TODO: Set up a function that'll let us toggle on and off.
-- In the meantime, just use this to disable the virtual text.
require('toggle_lsp_diagnostics').init({
  start_on = true,
  underline = true,
  virtual_text = false
})

require('lspconfig').ccls.setup({
  init_options = {
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

-- TODO: jdtls exits with error there.
require('lspconfig').jdtls.setup{}
require('lspconfig').pyright.setup({})
require('lspconfig').bashls.setup({})
require('lspconfig').texlab.setup({})
require('lspconfig').dockerls.setup({})
require('lspconfig').gopls.setup({})
require('lspconfig').jedi_language_server.setup{}
