-- Set up the CCLS language server. 

-- YO. AGAIN THIS ISN'T BEING SOURCED. WHAT???
-- Find out where TJDevries does it...

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
