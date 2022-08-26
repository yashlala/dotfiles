require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<tab>'] = require('telescope.actions').toggle_selection,
        ['<c-q>'] = require('telescope.actions').smart_send_to_qflist,
        ['<c-r>'] = require('telescope.actions').smart_send_to_loclist,
      },
      n = {
        ['<tab>'] = require('telescope.actions').toggle_selection,
        ['v'] = require('telescope.actions').toggle_selection,
        ['<c-q>'] = require('telescope.actions').smart_send_to_qflist,
        ['<c-r>'] = require('telescope.actions').smart_send_to_loclist,
      }
    },

    -- TODO: Set up a custom path_display function that will do smart
    -- shortening.
  },

  pickers = {
    file_browser = {
      mappings = {
        -- TODO: Add custom mapping here if we want.
      }
    }
  },

  extensions = {
    file_browser = {
      mappings = {
        -- ["n"] = {
        --   ["<C-a>"] = fb_actions.create_file,
        --   ["<C-d>"] = function(prompt_bufnr)
        --       -- your custom function logic here
        --       ...
        --     end
        -- }
      }
    }
  }
}

require('telescope').load_extension('fzf')

-- Integrate with `projects.nvim`
require('telescope').load_extension('projects')

-- Integrate with `telescope-file-browser.nvim`
require('telescope').load_extension('file_browser')

-- Integrate with `harpoon`
require('telescope').load_extension('harpoon')

-- integrate with `telescope-toggleterm.nvim`
require('telescope').load_extension('termfinder')
