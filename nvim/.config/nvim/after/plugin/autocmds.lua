local M = function()
  -- Re-compile packer after any edits to our config file.
  vim.api.nvim_exec([[
    augroup Packer
      autocmd!
      autocmd BufWritePost init.lua PackerCompile
      autocmd BufWritePost init.vim PackerCompile
    augroup end
  ]], true)

  -- Return to last edit position when opening files.
  vim.api.create_autocmd('BufReadPost', {
    pattern = '*',
    callback = function()
      local line = vim.fn.line("'\"")
      if 0 < line and line <= vim.fn.line("$") then
        vim.cmd('exe "normal! g`\""')
      end
   end,
    desc = 'Return to the last edit position when opening files.'
  })

  vim.api.create_autocmd({'BufNewFile', 'BufRead'}, {
    pattern = 'neomutt-*',
    callback = function()
      vim.bo.filetype = 'mail'
    end
  })

  -- Close netrw buffers (we can't do this by default, for some reason).
  vim.cmd('autocmd Filetype netrw setl bufhidden=delete')

  -- Enter terminal mode as soon as we create a terminal buffer.
  vim.cmd('autocmd TermOpen * startinsert')
  -- TODO: Why doesn't the below actually work?
  vim.cmd('autocmd TermOpen * setlocal signcolumn=no')
end

return M
