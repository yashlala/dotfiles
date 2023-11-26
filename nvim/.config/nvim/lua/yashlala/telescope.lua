require('telescope').setup {
  defaults = {
    -- TODO: Can we unmap the other mappings for telescope
    -- file browser buffers so d, c, etc work fine?
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
        ['<c-a>'] = require('telescope.actions').smart_add_to_qflist,
        ['<c-r>'] = require('telescope.actions').smart_send_to_loclist,
      }
    },

    -- TODO: Set up a custom path_display function that will do smart
    -- file path shortening.
  },
  extensions = {
    file_browser = {
      mappings = {
        ["i"] = {
          ["<bs>"] = false -- TODO this don't work
          -- TODO: binding to open a tty
        }
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
