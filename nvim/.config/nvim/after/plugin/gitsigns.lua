require('gitsigns').setup {
  keymaps = {
    -- Default keymap options
    noremap = true,
    ['n ]c'] = { expr = true,
      "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"
    },
    ['n [c'] = { expr = true,
      "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"
    },
    ['n <leader>gs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['v <leader>gs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>gu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>gr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['v <leader>gr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>gR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <leader>gp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>gb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
    ['n <leader>tgb'] = '<cmd>lua require"gitsigns".toggle_current_line_blame()<CR>',
    -- Text objects
    ['o ic'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    ['x ic'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
  },
  current_line_blame_opts = { virt_text_pos = 'eol', delay = 500 },
  diff_opts = { internal = true },
}
