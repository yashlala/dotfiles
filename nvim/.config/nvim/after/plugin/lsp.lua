-- TODO: Set up a function that'll let us toggle on and off.
-- In the meantime, just use this to disable the virtual text.
require('toggle_lsp_diagnostics').init({
  start_on = true,
  underline = true,
  virtual_text = false
})
