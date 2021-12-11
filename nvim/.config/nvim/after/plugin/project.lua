-- TODO: We're not remembering old projects anymore. 
-- Should we set manual_mode back to false? 
-- How should we deal with autochdir then? 
require('project_nvim').setup({ manual_mode = true })

require('telescope').load_extension('projects')
