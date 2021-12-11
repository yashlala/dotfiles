require('telescope').setup {}

require('telescope').load_extension('fzy_native')

-- Integrate with `projects.nvim`
require('telescope').load_extension('projects')
