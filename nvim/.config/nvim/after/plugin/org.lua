require('orgmode').setup_ts_grammar()

-- There are some treesitter hooks, so remember to clear those

require('orgmode').setup({
  mappings = {
    disable_all = true
  },
  org_agenda_files = {'~/code/org/*', '~/code/my-orgs/**/*'},
  org_default_notes_file = '~/code/org/refile.org',
  org_todo_keywords = { 'todo', '|', 'done' },
  org_log_into_drawer = { 'LOGBOOK' },
})
