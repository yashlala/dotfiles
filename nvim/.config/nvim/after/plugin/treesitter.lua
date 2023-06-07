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
    'org',
    'python',
    'regex',
    'rst',
    'rust',
    'scala',
    'scheme',
    'vim',
    'yaml'
  },
  sync_install = false,
  ignore_install = { }, -- List of parsers
  highlight = {
    enable = true,
    disable = { },  -- list of languages 
    -- Required since TS highlighter doesn't support all syntax features (conceal)
    additional_vim_regex_highlighting = { 'org' }
  },

  -- Don't use Treesitter to implement the `=` indentation operator yet. 
  -- It's still pretty buggy, looks like. 
  indent = { enable = false },

-- Define "incremental selection". When we already have a visual selection, 
-- we can use keybinds to expand or shrink the selection based on nearby
-- syntax. 
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<enter>',
      node_incremental = "<enter>",
      node_decremental = "<bs>",
    },
  },

  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["if"] = { query = "@function.inner", desc = "Select inner part of a function" },
        ["af"] = { query = "@function.outer", desc = "Select outer part of a function" },
        ["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
      },
      -- You can choose the select mode (default is charwise 'v')
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = 'V', -- linewise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding xor succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      include_surrounding_whitespace = true,
    },

    move = {
      enable = true,
      set_jumps = false, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
})
