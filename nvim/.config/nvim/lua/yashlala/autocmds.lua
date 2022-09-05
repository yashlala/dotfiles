local M = {}

M.setup = function()
  -- Re-compile packer after any edits to our config file.
  vim.cmd('autocmd BufWritePost init.lua PackerCompile')

  -- Return to last edit position when opening files.
  vim.api.nvim_create_autocmd('BufReadPost', {
    pattern = '*',
    callback = function()
      local line = vim.fn.line("'\"")
      if 0 < line and line <= vim.fn.line("$") then
        vim.cmd('exe "normal! g`\""')
      end
    end,
    desc = 'Return to the last edit position when opening files.'
  })

  vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    pattern = 'neomutt-*',
    callback = function()
      vim.bo.filetype = 'mail'
    end
  })

  -- Close netrw buffers (we can't do this by default, for some reason).
  vim.cmd('autocmd Filetype netrw setl bufhidden=delete')

  vim.cmd('autocmd TermOpen * startinsert')
  vim.cmd('autocmd TermOpen * setlocal signcolumn=no')
end

return M
