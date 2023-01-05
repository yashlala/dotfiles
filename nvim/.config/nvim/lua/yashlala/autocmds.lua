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
end

return M
