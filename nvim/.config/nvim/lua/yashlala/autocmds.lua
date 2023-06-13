local M = {}

M.setup = function()
  local groupid = vim.api.nvim_create_augroup('yashlala', {})

  -- Re-compile packer after any edits to our config file.
  vim.api.nvim_create_autocmd('BufWritePost', {
    group = groupid,
    pattern = 'init.lua',
    command = 'PackerCompile',
  })

  -- Return to last edit position when opening files.
  vim.api.nvim_create_autocmd('BufReadPost', {
    group = groupid,
    callback = function()
      local line = vim.fn.line("'\"")
      if 0 < line and line <= vim.fn.line('$') then
        vim.cmd('normal! g`"')
      end
    end,
    desc = 'Return to the last edit position when opening files.',
  })

  vim.api.nvim_create_autocmd('CursorHold', {
    group = groupid,
    callback = function() print('\n') end,
    desc = 'Clear the message bar from time to time',
  })

  vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    group = groupid,
    pattern = 'neomutt-*',
    command = 'setlocal filetype=mail',
  })

  -- Close netrw buffers (can't do this by default, for some reason).
  vim.api.nvim_create_autocmd('FileType', {
    group = groupid, pattern = 'netrw',
    command = 'setlocal bufhidden=delete',
  })

  vim.api.nvim_create_autocmd('TermOpen', {
    group = groupid,
    command = 'startinsert',
  })

  vim.api.nvim_create_autocmd('TermOpen', {
    group = groupid,
    command = 'setlocal signcolumn=no',
  })

  -- Many of our ordinary keybinds fail in the command window.
  -- We disable or fix these maps via this autocommand.
  vim.api.nvim_create_autocmd('CmdWinEnter', {
    group = groupid,
    callback = function ()
      local set = function(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, { buffer = true })
      end

      local to_unmap = {
        '<cr>', '<bs>', -- mapped to nvim treesitter textobjs
        'f', 't', 'F', 'T', -- mapped to hop.nvim
      }
      for _, key in pairs(to_unmap) do
        set({'n', 'v'}, key, key)
      end

      -- Fix window navigation keybinds
      for _, lhs in pairs({ '<m-h>', '<m-j>', '<m-k>', '<m-l>'}) do
        set({'n', 'i', 'v'}, lhs, '<cmd>quit<cr>')
      end
    end,
    desc = 'Set keybinds for command window',
  })
end

return M
