require('gitsigns').setup {
  on_attach = function (bufnr)
    local gs = package.loaded.gitsigns

    local map = function(mode, lhs, rhs, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    map('n', '<leader>gs', function() gs.stage_hunk() end)
    map('v', '<leader>gs', function()
      gs.stage_hunk({vim.fn.line("."), vim.fn.line("v")})
    end)
    map('n', '<leader>gu', function() gs.undo_stage_hunk() end)
    map('n', '<leader>gr', function() gs.reset_hunk() end)
    map('v', '<leader>gr', function()
      gs.reset_hunk({vim.fn.line("."), vim.fn.line("v")})
    end)
    map('n', '<leader>gR', function() gs.reset_buffer() end)
    map('n', '<leader>gp', function() gs.preview_hunk() end)
    map('n', '<leader>gb', function()
      gs.blame_line({full=true, ignore_whitespace=true})
    end)
    map('n', '<leader>gB', function() gs.toggle_current_line_blame() end)

    local gsa = require('gitsigns.actions')

    map('n', ']c', function()
      if vim.wo.diff then return ']c' else gsa.next_hunk() end
    end)
    map('n', '[c', function()
      if vim.wo.diff then return '[c' else gsa.prev_hunk() end
    end)

    -- Text objects; "in git change", or "all git change"
    map({'o', 'x'}, 'igc', function() gsa.select_hunk() end )
    map({'o', 'x'}, 'agc', function() gsa.select_hunk() end )
  end,
  current_line_blame_opts = { virt_text_pos = 'eol', delay = 500 },
  diff_opts = { internal = true },
}
