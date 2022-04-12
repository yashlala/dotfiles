-- Set up smarter syntax highlighting using treesitter. 
require('nvim-treesitter.configs').setup({
  ensure_installed = { 
    'bash', 
    'bibtex', 
    'c', 
    'clojure', 
    'cmake', 
    'comment', 
    'commonlisp', 
    'cpp',
    'css',
    'cuda',
    'devicetree',
    'dockerfile',
    'go',
    'gomod',
    'gowork',
    'html',
    'java',
    'javascript',
    'jsdoc',
    'json',
    'json5',
    'latex',
    'llvm',
    'lua',
    'make',
    'nix',
    'ocaml',
    'python',
    'regex',
    'rst',
    'rust',
    'scheme',
    'scala',
    'vim',
    'yaml'
  }, 
  sync_install = false, 
  ignore_install = { }, -- List of parsers
  highlight = {
    enable = true, 
    disable = { },  -- list of languages 
    additional_vim_regex_highlighting = false,
  },
})

-- Don't use Treesitter to implement the `=` indentation operator yet. 
-- It's still pretty buggy, looks like. 
require('nvim-treesitter.configs').setup({
  indent = { enable = false }
})

-- Define "incremental selection". When we already have a visual selection, 
-- we can use keybinds to expand or shrink the selection based on nearby
-- syntax. 
-- TODO: Verify if we actually need or use this. Might use it to replace
-- things...but probably not. Map something to `V`? 
require('nvim-treesitter.configs').setup({
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
})
