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
  vim.api.nvim_exec([[
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  ]], false)

  -- Read neomutt filetypes correctly.
  vim.api.nvim_exec([[
  autocmd BufNewFile,BufRead neomutt-* set filetype=mail
  ]], false)

  -- Close netrw buffers (we can't do this by default, for some reason).
  vim.api.nvim_exec("autocmd Filetype netrw setl bufhidden=delete", false)

  -- Enter terminal mode as soon as we create a terminal buffer.
  vim.api.nvim_exec("autocmd TermOpen * startinsert", false)
  -- TODO: Why doesn't the below actually work?
  vim.api.nvim_exec("autocmd TermOpen * setlocal signcolumn=no", false)

  -- The bottom status line doesn't update very often, so the buffer listing can
  -- become stale. Avoid this by throwing in a few autocommands (we have a
  -- function later in this file that mitigates this problem as well)
  -- TODO: Stop using the line altogether. We have a keymap now.
  vim.api.nvim_exec([[
  autocmd BufEnter,BufLeave,BufWritePost,BufHidden,BufWinEnter,BufWinLeave,CmdlineEnter,InsertEnter *
    \ call lightline#update()
  ]], false)
end

return M
