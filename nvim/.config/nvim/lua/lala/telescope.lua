require('telescope').setup {
  defaults = { 
    mappings = { 
      i = { 
        ['<tab>'] = require('telescope.actions').toggle_selection
        ['<c-q>'] = require('telescope.actions').smart_send_to_qflist
        ['<c-r>'] = require('telescope.actions').smart_send_to_loclist
      },
      n = { 
        ['<tab>'] = require('telescope.actions').toggle_selection
        ['v'] = require('telescope.actions').toggle_selection
        ['<c-q>'] = require('telescope.actions').smart_send_to_qflist
        ['<c-r>'] = require('telescope.actions').smart_send_to_loclist
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
  }
}

require('telescope').load_extension('fzf')

-- Integrate with `projects.nvim`
require('telescope').load_extension('projects')
