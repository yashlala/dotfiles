setlocal expandtab
setlocal formatoptions+=tcrn1 formatoptions-=o
setlocal cinoptions+=l1,:n1
setlocal shiftwidth=4
setlocal textwidth=79


lua <<EOF

require('lspconfig').ccls.setup({
  init_options = {
    --cache = {
	--directory = "/home/lala/.cache/ccls";
    --};
    compilationDatabaseDirectory = "build";
    index = {
      threads = 0;
    };
    clang = {
      excludeArgs = { "-frounding-math"};
    };
  }
})


EOF
