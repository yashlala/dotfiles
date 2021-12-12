require('telescope').setup {
  -- TODO: Adjust default mappings. Quickfix is great!
  mappings = { 
    -- Insert mode mappings inside telescope
    i = { 
      -- ["<c-a>"] = function() 
      -- Do something here, I think?
    }
  }
}

require('telescope').load_extension('fzf')

-- Integrate with `projects.nvim`
require('telescope').load_extension('projects')
