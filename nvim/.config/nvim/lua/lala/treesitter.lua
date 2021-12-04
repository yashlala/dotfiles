-- Set up smarter syntax highlighting using treesitter. 
require('nvim-treesitter.configs').setup({
  ensure_installed = "maintained", 
  sync_install = false, 
  ignore_install = { }, -- List of parsers
  highlight = {
    enable = true, 
    disable = { },  -- list of languages 
    additional_vim_regex_highlighting = false,
  },
})

-- Use Treesitter to implement the `=` indentation operator
require('nvim-treesitter.configs').setup({
  indent = { enable = true }
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
} )
