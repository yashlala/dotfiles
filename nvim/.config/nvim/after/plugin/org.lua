local org = require('orgmode')

org.setup_ts_grammar()
-- There are some treesitter hooks, so remember to clear those. TODO?

vim.keymap.set('n', '<leader>o', '<nop>') -- clean aborts to keymaps
org.setup({
  org_agenda_files = {'~/documents/org/*', '~/documents/my-orgs/**/*'},
  org_default_notes_file = '~/documents/org/refile.org',
  org_todo_keywords = { 'todo(t)', 'blocked(b)', '|', 'done(d)' },
  org_log_into_drawer = { 'LOGBOOK' },

  mappings = {
    capture = {
      org_capture_finalize = '<leader>oy', -- leader yes
      org_capture_kill = '<leader>on', -- leader no
      org_capture_refile = '<leader>or',-- leader refile
    },
  },
})
